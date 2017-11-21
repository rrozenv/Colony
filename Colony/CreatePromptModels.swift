
import Foundation

enum CreatePrompt {
    
    enum Create {
        struct Request {
            let title: String
            let body: String
        }
        
        struct Response {
            var promt: Prompt
        }
        
        struct Alert {
            static func createConfirmation() -> CustomAlertViewController.AlertInfo {
                return CustomAlertViewController.AlertInfo(header: "Prompt Created", message: "Success!", okButtonTitle: "OK", cancelButtonTitle: nil)
            }
        }
    }
    
}
