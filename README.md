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
