
import Foundation
import Moya

struct Resource<A> {
    let target: TargetType
    let parse: (Data) -> A?
}

extension Resource {
    init(target: TargetType, parseJSON: @escaping (Any) -> A?) {
        self.target = target
        self.parse = { data -> A? in
            let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments])
            return json.flatMap(parseJSON)
        }
    }
}
