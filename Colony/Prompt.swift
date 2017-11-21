
import Foundation
import RealmSwift

class Prompt: Object {
    dynamic var uniqueID: String = UUID().uuidString
    dynamic var title: String = ""
    dynamic var body: String = ""
    dynamic var time = Date().timeIntervalSince(Date())
    
    override static func primaryKey() -> String? {
        return "uniqueID"
    }
    
    convenience init(title: String, body: String) {
        self.init()
        self.title = title
        self.body = body
    }
}
