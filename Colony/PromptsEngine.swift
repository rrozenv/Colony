
import Foundation
import UIKit
import PromiseKit

protocol PromptsListBusinessLogic {
    func fetchPrompts(request: Prompts.FetchPrompts.Request)
}

protocol PromptsListDataStore {
    var prompts: [Prompt] { get }
}

final class PromptsListEngine: PromptsListBusinessLogic, PromptsListDataStore {
    
    var formatter: PromptsFormattingLogic?
    var prompts: [Prompt] = []
    
    lazy var commonRealm: RealmStorageContext = {
        return RealmStorageContext(configuration: RealmConfig.common)
    }()
    
    func fetchPrompts(request: Prompts.FetchPrompts.Request) {
        self.commonRealm
            .fetch(Prompt.self)
            .then { [weak self] (prompts) -> Void in
                self?.prompts = prompts
                let response = Prompts.FetchPrompts.Response(prompts: prompts)
                self?.formatter?.formatPrompts(response: response)
            }
            .catch { (error) in
                if let realmError = error as? RealmError {
                    print(realmError.description)
                } else {
                    print(error.localizedDescription)
                }
            }
    }

}




