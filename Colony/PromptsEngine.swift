
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
    
    func fetchPrompts(request: Prompts.FetchPrompts.Request) {
        
    }

}




