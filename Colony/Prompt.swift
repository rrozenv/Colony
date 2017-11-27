
import Foundation
import RealmSwift

class Prompt: Object {
    dynamic var uniqueID: String = UUID().uuidString
    dynamic var title: String = ""
    dynamic var body: String = ""
    dynamic var imageURL: String = ""
    dynamic var time = Date().timeIntervalSince(Date())
    let replies = List<PromptReply>()
    
    override static func primaryKey() -> String? {
        return "uniqueID"
    }
    
    convenience init(title: String, body: String, imageURL: String) {
        self.init()
        self.title = title
        self.body = body
        self.imageURL = imageURL
    }
    
    static func valueDict(title: String, body: String, imageURL: String) -> [String: Any] {
        return ["title": title, "body": body, "imageURL": imageURL]
    }
}


