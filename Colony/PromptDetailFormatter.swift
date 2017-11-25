
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
            let userScore = getAlreadyCastedScore(for: $0)
            return DisplayedReply(id: $0.uniqueID, userName: $0.userName, body: $0.body, userScore: userScore ?? nil)
        })
    }
    
    private func getAlreadyCastedScore(for reply: PromptReply) -> String? {
        guard let user = User.loadCurrentUser() else { fatalError() }
        if let score = reply.userScores.filter(NSPredicate(format: "userId = %@", user.id)).first {
            return score.score
        } else {
            return nil
        }
    }
    
}
