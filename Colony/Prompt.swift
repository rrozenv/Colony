
import Foundation
import RealmSwift

class Prompt: Object {
    dynamic var uniqueID: String = UUID().uuidString
    dynamic var title: String = ""
    dynamic var body: String = ""
    dynamic var time = Date().timeIntervalSince(Date())
    let replies = List<PromptReply>()
    
    override static func primaryKey() -> String? {
        return "uniqueID"
    }
    
    convenience init(title: String, body: String) {
        self.init()
        self.title = title
        self.body = body
    }
    
    static func valueDict(title: String, body: String) -> [String: Any] {
        return ["title": title, "body": body]
    }
}

class PromptReply: Object {
    dynamic var uniqueID: String = UUID().uuidString
    dynamic var userId: String = ""
    dynamic var userName: String = ""
    dynamic var body: String = ""
    dynamic var time = Date().timeIntervalSince(Date())
    
    override static func primaryKey() -> String? {
        return "uniqueID"
    }
    
    convenience init(user: User, title: String, body: String) {
        self.init()
        self.userId = user.id
        self.userName = user.name
        self.body = body
    }
    
    static func valueDict(user: User, title: String, body: String) -> [String: Any] {
        return ["userId": user.id, "userName": user.name, "title": title, "body": body]
    }
}
