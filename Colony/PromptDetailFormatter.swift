
import Foundation
import UIKit

typealias DisplayedReply = PromptDetail.FetchPromptReplies.ViewModel.DisplayedReply

protocol PromptDetailFormattingLogic {
    func formatPromptReplies(response: PromptDetail.FetchPromptReplies.Response)
}

final class PromptDetailFormatter: PromptDetailFormattingLogic {
    
    weak var viewController: PromptDetailDisplayLogic?
    
     func formatPromptReplies(response: PromptDetail.FetchPromptReplies.Response) {
        let displayedReplies = mapToDisplayedReplies(response.replies)
        let viewModel = PromptDetail.FetchPromptReplies.ViewModel(replies: displayedReplies)
        viewController?.displayPromptReplies(viewModel: viewModel)
    }
    
    private func mapToDisplayedReplies(_ replies: [PromptReply]) -> [DisplayedReply] {
        return replies.map({
            return DisplayedReply(userName: $0.userName, body: $0.body)
        })
    }
    
}
