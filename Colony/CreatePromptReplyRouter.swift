
import Foundation
import UIKit

@objc protocol CreatePromptReplyRoutingLogic {
    func routeToPromptDetail()
}

protocol CreatePromptReplyDataPassing {
    var dataStore: CreatePromptReplyDataStore? { get }
}

class CreatePromptReplyRouter: NSObject, CreatePromptReplyRoutingLogic, CreatePromptReplyDataPassing {
    
    weak var viewController: CreatePromptReplyViewController?
    var dataStore: CreatePromptReplyDataStore?
    
    // MARK: Routing
    func routeToPromptDetail() {
        navigateToPromptDetail()
    }
    
    func navigateToPromptDetail() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
}
