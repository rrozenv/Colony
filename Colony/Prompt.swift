
import Foundation
import RealmSwift

protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

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

class Prompt_R: Object {
    dynamic var id: String = ""
    dynamic var title: String = ""
    dynamic var body: String = ""
    dynamic var imageURL: String = ""
    dynamic var createdAt = Date()
    let replies = List<PromptReply>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(title: String, body: String, imageURL: String) {
        self.init()
        self.title = title
        self.body = body
        self.imageURL = imageURL
    }
    
    static func valueDict(title: String, body: String, imageURL: String) -> [String: Any] {
        return ["id": UUID().uuidString, "title": title, "body": body, "imageURL": imageURL]
    }
}

struct PromptT {
    let id: String
    let title: String
    let body: String
    let imageUrl: String
    var createdAt: Date?
}

extension PromptT {
    init?(dictionary: JSONDictionary) {
        guard let id = dictionary["id"] as? Int,
            let title = dictionary["title"] as? String,
            let body = dictionary["body"] as? String,
            let imageUrl = dictionary["imageUrl"] as? String,
            let createdAt = dictionary["createdAt"] as? String else { return nil }
        self.id = String(id)
        self.title = title
        self.body = body
        self.imageUrl = imageUrl
        self.createdAt = createdAt.date
    }
}

extension PromptT: Persistable {
    
    init(managedObject: Prompt_R) {
        id = managedObject.id
        title = managedObject.title
        body = managedObject.body
        imageUrl = managedObject.imageURL
    }
    
    func managedObject() -> Prompt_R {
        let object = Prompt_R()
        object.id = id
        object.title = title
        object.body = body
        object.imageURL = imageUrl
        return object
    }
    
}

extension PromptT {
    
    static func allPrompts() -> Resource<[PromptT]> {
        return Resource<[PromptT]>(target: OutpostAPI.getPrompts) { json -> [PromptT]? in
            guard let jsonDicts = json as? [JSONDictionary] else { return nil }
            return jsonDicts.flatMap({ (dictionary) -> PromptT? in
                return PromptT(dictionary: dictionary)
            })
        }
    }
    
}

extension String {
    
    var date: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let calendar = Calendar.current
        guard let date = formatter.date(from: self) else { return nil }
        let components = calendar.dateComponents([.month, .day, .hour, .minute], from: date)
        let finalDate = calendar.date(from:components)
        return finalDate
    }
    
}


