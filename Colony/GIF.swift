
import Foundation

typealias JSONDictionary = [String: Any]

protocol Imageable {
    var id: String { get }
    var urlString: String { get }
}

struct GIF: Imageable {
    var id: String
    var urlString: String
    
    init?(dictionary: JSONDictionary) {
        guard let id = dictionary["id"] as? String,
              let urlString = dictionary["url"] as? String else { return nil }
        self.id = id
        self.urlString = urlString
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

struct PixaImage: Imageable {
    var id: String
    var urlString: String
    
    init?(dictionary: JSONDictionary) {
        guard let id = dictionary["id"] as? Int,
            let urlString = dictionary["webformatURL"] as? String else { return nil }
        self.id = String(id)
        self.urlString = urlString
    }
}

extension PixaImage {
    
    static func PixaImageResource(for query: String) -> Resource<[Imageable]> {
        return Resource<[Imageable]>(target: PixabayAPI.search(query: query)) { json -> [Imageable]? in
            guard let jsonDict = json as? JSONDictionary else { return nil }
            guard let dictionaries = jsonDict["hits"] as? [JSONDictionary] else { return nil }
            return dictionaries.flatMap({ (dictionary) -> Imageable? in
                return PixaImage(dictionary: dictionary)
            })
        }
    }
    
}
