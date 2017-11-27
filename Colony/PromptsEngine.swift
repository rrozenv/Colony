
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
        let prompts = self.commonRealm.fetch(Prompt.self)
        self.prompts = prompts
        self.generateResponseForPresenter(with: prompts)
    }
    
    fileprivate func generateResponseForPresenter(with prompts: [Prompt]) {
        let response = Prompts.FetchPrompts.Response(prompts: prompts)
        self.formatter?.formatPrompts(response: response)
    }

}




