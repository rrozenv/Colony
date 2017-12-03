
import Foundation
import RealmSwift

class User: Object {
    
    // MARK: - Properties
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var email: String = ""
    let replies = List<PromptReply>()
    
    // MARK: - Init
    convenience init(syncUser: SyncUser, name: String, email: String) {
        self.init()
        self.id = syncUser.identity ?? ""
        self.name = name
        self.email = email
    }
    
    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "id"
    }
    
    class func valueDict(name: String, email: String) -> [String: Any] {
        return ["id": SyncUser.current!.identity!, "name": name, "email": email]
    }
    
    class func loadUser(_ name: String? = nil, _ email: String? = nil) -> User? {
        let commonRealm =  try! Realm(configuration: RealmConfig.common.configuration)
        var user = commonRealm.objects(User.self).filter(NSPredicate(format: "id = %@", SyncUser.current!.identity!)).first
        if user == nil {
            try! commonRealm.write {
                user = commonRealm.create(User.self, value:["id": SyncUser.current!.identity!, "name": name, "email": email])
                commonRealm.add(user!, update: true)
            }
        }
        return user
    }
    
    class func loadCurrentUser() -> User? {
        let commonRealm =  try! Realm(configuration: RealmConfig.common.configuration)
        let user = commonRealm.objects(User.self).filter(NSPredicate(format: "id = %@", SyncUser.current!.identity!)).first
        return user
    }
    
}
