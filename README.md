# Tutorials

- [Consume Remote Services in SAP S/4HANA](https://developers.sap.com/group.sap-s4hana-consume-remote-services.html)
- [Full-Stack Application with CAP](https://developers.sap.com/group.cap-application-full-stack.html)

---

## 1. Initialize Project

To initialize your project, run the following command:

```shell
cds init incident-management
```

---

## 2. Use `cds watch`

`cds watch` is recommended as it detects `cds-tsx` under the hood after detecting `tsconfig.json`. While `cds-ts` can also be used, `cds-tsx` is generally faster.

Run the following command:

```shell
cds watch
```

---

## 3. Add TypeScript Declarations for CAP

Install `@cap-js/cds-types`, which contains all TypeScript declarations for the `@sap/cds` APIs. These declarations are used automatically when writing TypeScript files and enable IntelliSense and type checking in Visual Studio Code.

Install the package:

```shell
npm add @cap-js/cds-types
```

Then, run `npm install` after adding dependencies.

Use the TypeScript declarations as follows:

```typescript
import { Request } from "@sap/cds";

function myHandler(req: Request) {}
```

Import types through the `cds` facade class, which provides access to all CAP Node.js APIs:

```typescript
import { ... } from '@sap/cds'
```

For more information on enabling TypeScript support, visit [CAP TypeScript Documentation](https://cap.cloud.sap/docs/node.js/typescript#enable-typescript-support).

---

## 4. Add Test Cases

Install the necessary dependencies for testing:

```shell
npm add -D axios chai@4 chai-as-promised@7.1.2 chai-subset jest
```

---

## 5. Add HANA

To add HANA support for production, run the following command:

```shell
cds add hana --for production
```

Check the environment for production:

```shell
cds env requires -4 production
```

---

## 6. Add Authorization

To add authorization support for production, run the following command:

```shell
cds add xsuaa --for production
```

---

## 7. Add HTML5 with Deploy Configurations

To add HTML5 with deploy configurations, run the following command:

```shell
cds add html5-repo
```

---

## 8. Run Build for Production

To build the project for production, run the following command:

```shell
cds build --production
```
