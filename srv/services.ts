import cds, { Service } from "@sap/cds";
// import { Request } from "@sap/cds/apis/services"; // For `req` type
// import { Incidents } from "#cds-models/ProcessorService"; // Replace with the correct types for your model
// import { BusinessPartner } from "#cds-models/API_BUSINESS_PARTNER"; // Replace with correct type

class ProcessorService extends cds.ApplicationService {
  private S4bupa!: Service; // Type for the S/4HANA service connection
  private remoteService!: Service; // Type for the remote service connection

  async init() {
    this.S4bupa = await cds.connect.to("API_BUSINESS_PARTNER");
    this.remoteService = await cds.connect.to("RemoteService");
    const { Incidents } = require("#cds-models/ProcessorService");
    this.before("UPDATE", Incidents, (req) => this.onUpdate(req));
    // this.on("READ", "Customers", (req) => this.onCustomerRead(req));

    // this.before("UPDATE", Incidents, async (req) => {
    //   this.onUpdate(req);
    // });
    this.before("CREATE", Incidents, (req) =>
      this.changeUrgencyDueToSubject(req.data)
    );

    return super.init();
  }
  async onCustomerRead(req: any) {
    console.log(">> delegating to S4 service...", req.query);
    const top = parseInt(req._queryOptions?.$top) || 100;
    const skip = parseInt(req._queryOptions?.$skip) || 0;

    const { BusinessPartner } = cds.entities as any; // Replace `any` with your actual type if available

    // Expands are required as the runtime does not support path expressions for remote services
    let result = await this.S4bupa.run(
      SELECT.from(BusinessPartner, (bp: any) => {
        bp("*"),
          bp.addresses((address: any) => {
            address("email"),
              address.email((emails: any) => {
                emails("email");
              });
          });
      }).limit(top, skip)
    );

    result = result.map((bp: any) => ({
      ID: bp.ID,
      name: bp.name,
      email: bp.addresses[0]?.email[0]?.email,
    }));

    // Explicitly set $count so the values show up in the value help in the UI
    result.$count = 1000;
    console.log("after result", result);
    return result;
  }
  changeUrgencyDueToSubject(data: any) {
    debugger;
    if (data) {
      const incidents = Array.isArray(data) ? data : [data];
      incidents.forEach((incident) => {
        if (incident.title?.toLowerCase().includes("urgent")) {
          incident.urgency = { code: "H", descr: "High" };
        }
      });
    }
  }

  /** Custom Validation */
  async onUpdate(req: any) {
    debugger;
    const { status_code } = await SELECT.one(
      req.subject,
      (i) => i.status_code
    ).where({ ID: req.data.ID });
    if (status_code === "C")
      return req.reject(`Can't modify a closed incident`);
  }
}

module.exports = { ProcessorService };
