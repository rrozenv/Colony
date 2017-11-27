
import Foundation
import Moya

enum PixabayAPI {
    case search(query: String)
}

extension PixabayAPI: TargetType {
    
    // 3:
    var baseURL: URL {
        switch self {
        case .search(query: _):
            return URL(string: "https://pixabay.com/api/")!
        }
    }
    
    // 4:
    var path: String {
        switch self {
        case .search(query: _):
            return ""
        }
    }
    
    // 5:
    var method: Moya.Method {
        switch self {
        default: return .get
        }
    }
    
    // 6:
    var parameters: [String: Any]? {
        switch self {
        case .search(query: let query):
            var parameters = [String: Any]()
            parameters["q"] = "\(query)"
            parameters["key"] = Secrets.pixabayAPI_Key
            return parameters
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    // 7:
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    // 8:
    var sampleData: Data {
        return Data()
    }
    
    // 9:
    var task: Task {
        return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
    }
}
