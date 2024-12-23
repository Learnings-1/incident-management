####Tutorials

```url
https://developers.sap.com/group.sap-s4hana-consume-remote-services.html
https://developers.sap.com/group.cap-application-full-stack.html
```

1. Initialize Project

```shell
cds init incident-management
```

2. use cds watch because it detects cds-tsx watch under the hood after detecting tsconfig.json.
   Can also use cds-ts but tsx is better choice as it faster

```shell
cds watch
```

3. npm add @cap-js/cds-types.contains all TypeScript declarations for @sap/cds APIs. These declarations are used automatically when you write TypeScript files, but also enable IntelliSense and type checking for standard JavaScript development in Visual Studio Code. Just add the @cap-js/cds-types package to your project as follows

```shell
npm add @cap-js/cds-types
#Do npm install after adding dependecies
# Use the Typescript declarations like this: https://cap.cloud.sap/docs/node.js/typescript#enable-typescript-support
import { Request } from '@sap/cds'

function myHandler(req: Request) { }

#Import types through the cds facade class only:The cds facade object provides access to all CAP Node.js APIs. https://cap.cloud.sap/docs/node.js/cds-facade
import { ... } from '@sap/cds'
```

4. Add test cases

```shell
npm add -D axios chai@4 chai-as-promised@7.1.2 chai-subset jest
```

5. Add HANA

```shell
cds add hana --for production

# check env for production
cds env requires -4 production

```

6. Add Authorization

```shell
cds add xsuaa --for production

```

7. Add HTML5 with deploy configurations

```shell
cds add html5-repo
```

8. Run Build for production

```shell
cds build --production
```
