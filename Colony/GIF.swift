
import Foundation

typealias JSONDictionary = [String: Any]

struct GIF {
    let id: String
    let url: String
    
    init?(dictionary: JSONDictionary) {
        guard let id = dictionary["id"] as? String,
            let url = dictionary["url"] as? String else { return nil }
        self.id = id
        self.url = url
    }
}

extension GIF {
    
    static func GIFResource(for query: String) -> Resource<[GIF]> {
        return Resource<[GIF]>(target: GifAPI.search(query: query)) { json -> [GIF]? in
            guard let jsonDict = json as? JSONDictionary else { return nil }
            guard let dictionaries = jsonDict["data"] as? [JSONDictionary] else { return nil }
            return dictionaries.flatMap({ (dictionary) -> GIF? in
                return GIF(dictionary: dictionary)
            })
        }
    }
    
}
