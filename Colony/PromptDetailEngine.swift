
import Foundation

protocol PromptDetailLogic {
    func fetchPromptReplies(request: PromptDetail.FetchPromptReplies.Request)
}

protocol PromptDetailDataStore {
    var prompt: Prompt! { get }
}

final class PromptDetailEngine: PromptDetailLogic, PromptDetailDataStore {
    
    var formatter: PromptDetailFormattingLogic?
    var prompt: Prompt!
    
    func fetchPromptReplies(request: PromptDetail.FetchPromptReplies.Request) {
        let replies = Array(prompt.replies)
        let response = PromptDetail.FetchPromptReplies.Response(replies: replies)
        formatter?.formatPromptReplies(response: response)
    }
    
}
