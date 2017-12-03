
import Foundation
import RealmSwift

class UserScore: Object {
    dynamic var uniqueID: String = UUID().uuidString
    dynamic var replyId: String = ""
    dynamic var userId: String = ""
    dynamic var score: String = ""
    
    override static func primaryKey() -> String? {
        return "uniqueID"
    }
    
    convenience init(user: User, replyId: String, score: String) {
        self.init()
        self.userId = user.id
        self.replyId = replyId
        self.score = score
    }
    
    static func valueDict(user: User, replyId: String, score: String) -> [String: Any] {
        return ["userId": user.id, "replyId": replyId, "score": score]
    }
}


class PromptReply: Object {
    dynamic var uniqueID: String = UUID().uuidString
    dynamic var userId: String = ""
    dynamic var userName: String = ""
    dynamic var promptId: String = ""
    dynamic var body: String = ""
    let userScores = List<UserScore>()
    dynamic var time = Date().timeIntervalSince(Date())
    
    override static func primaryKey() -> String? {
        return "uniqueID"
    }
    
    convenience init(user: User, prompt: Prompt, body: String) {
        self.init()
        self.userId = user.id
        self.userName = user.name
        self.promptId = prompt.id
        self.body = body
    }
    
    static func valueDict(user: User, body: String) -> [String: Any] {
        return ["userId": user.id, "userName": user.name, "body": body]
    }
}
