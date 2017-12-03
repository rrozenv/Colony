//
//  OutpostAPI.swift
//  Colony
//
//  Created by Robert Rozenvasser on 12/1/17.
//  Copyright © 2017 GoKid. All rights reserved.
//

import Foundation
import Moya

enum OutpostAPI {
    case getPrompts
}

extension OutpostAPI: TargetType {
    
    // 3:
    var baseURL: URL {
        switch self {
        case .getPrompts:
            return URL(string: "https://outpost.vapor.cloud")!
        }
    }
    
    // 4:
    var path: String {
        switch self {
        case .getPrompts:
            return "/prompts"
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
        let parameters = [String: Any]()
        switch self {
        case .getPrompts:
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
