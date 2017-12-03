
import Foundation
import UIKit
import PromiseKit

protocol PromptsListBusinessLogic {
    func fetchPrompts(request: Prompts.FetchPrompts.Request)
}

protocol PromptsListDataStore {
    var prompts: [PromptT] { get }
}

final class PromptsListEngine: PromptsListBusinessLogic, PromptsListDataStore {
    
    var formatter: PromptsFormattingLogic?
    var prompts: [PromptT] = []
    let webservice = WebService.shared
    
    lazy var commonRealm: RealmStorageContext = {
        return RealmStorageContext(configuration: RealmConfig.common)
    }()
    
    func fetchPrompts(request: Prompts.FetchPrompts.Request) {
//        let resource = PromptT.allPrompts()
//        webservice.load(resource)
//            .then { (prompts) -> Void in
//                self.prompts = prompts
//                self.generateResponseForPresenter(with: prompts)
//            }
//            .catch { (error) in
//                print(error.localizedDescription)
//            }
        let prompts = self.commonRealm.fetchTest(PromptT.self)
        self.generateResponseForPresenter(with: prompts)
    }
    
    fileprivate func generateResponseForPresenter(with prompts: [PromptT]) {
        let response = Prompts.FetchPrompts.Response(prompts: prompts)
        self.formatter?.formatPrompts(response: response)
    }

}




