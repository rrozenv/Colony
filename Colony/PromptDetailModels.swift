
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
                let userName: String
                let body: String
            }
            var replies: [DisplayedReply]
        }
    }
    
}
