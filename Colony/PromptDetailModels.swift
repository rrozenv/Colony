
import Foundation

enum PromptDetail {
    
    enum FetchPromptReplies {
        struct Request { }
        
        struct Response {
            var replies: [PromptReply]
        }
        
        //Presenter Output -> View Controller Input
        struct ViewModel {
            struct DisplayedReply {
                let id: String
                let userName: String
                let body: String
                let userScore: String?
            }
            var replies: [DisplayedReply]
        }
    }
    
    enum SaveUserScoreForReply {
        struct Request {
            let replyId: String
            let score: String
        }
    }
    
}
