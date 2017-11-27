
import Foundation
import UIKit

typealias DisplayedPrompt = Prompts.FetchPrompts.ViewModel.DisplayedPrompt

protocol PromptsFormattingLogic {
    func formatPrompts(response: Prompts.FetchPrompts.Response)
}

final class PromptsFormatter: PromptsFormattingLogic {
    
    weak var viewController: PromptsDisplayLogic?
 
    func formatPrompts(response: Prompts.FetchPrompts.Response) {
        let displayedPrompts = mapToDisplayedPrompts(response.prompts)
        let viewModel = Prompts.FetchPrompts.ViewModel(prompts: displayedPrompts)
        viewController?.displayPrompts(viewModel: viewModel)
    }
    
    private func mapToDisplayedPrompts(_ prompts: [Prompt]) -> [DisplayedPrompt] {
        return prompts.map({
            return DisplayedPrompt(title: $0.title, body: $0.body, imageURL: URL(string: $0.imageURL), replyCount: String($0.replies.count))
        })
    }
    
}
