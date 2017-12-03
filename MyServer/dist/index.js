"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const realm_object_server_1 = require("realm-object-server");
const path = require("path");
const server = new realm_object_server_1.BasicServer();
server.start({
    dataPath: path.join(__dirname, '../data')
})
    .then(() => {
    console.log(`Your server is started `, server.address);
})
    .catch(err => {
    console.error(`There was an error starting your file`);
});
//# sourceMappingURL=index.js.map