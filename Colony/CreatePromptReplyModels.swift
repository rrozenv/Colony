
import Foundation

enum CreatePromptReply {
    
    enum Create {
        struct Request {
            let body: String
        }
        
        struct Response {
            var promptReply: PromptReply
        }
        
        struct Alert {
            static func createConfirmation() -> CustomAlertViewController.AlertInfo {
                return CustomAlertViewController.AlertInfo(header: "Prompt Created", message: "Success!", okButtonTitle: "OK", cancelButtonTitle: nil)
            }
        }
    }
    
}
