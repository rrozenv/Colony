import { BasicServer } from 'realm-object-server'
import * as path from 'path'

const server = new BasicServer()
const facebookProvider = new FacebookAuthProvider()

server.start({
        dataPath: path.join(__dirname, '../data')
	authProviders: [ facebookProvider ],
    })
    .then(() => {
        console.log(`Your server is started `, server.address)
    })
    .catch(err => {
        console.error(`There was an error starting your file`)
    })