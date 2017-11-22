
import Foundation
import UIKit

@objc protocol PromptDetailRoutingLogic {
    func routeToCreatePromptReply()
}

protocol PromptDetailDataPassing {
    var dataStore: PromptDetailDataStore? { get }
}

class PromptDetailRouter: NSObject, PromptDetailRoutingLogic, PromptDetailDataPassing {
    
    weak var viewController: PromptDetailViewController?
    var dataStore: PromptDetailDataStore?
    
    // MARK: Routing
    func routeToCreatePromptReply() {
        let destinationVC = CreatePromptReplyViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToCreatePromptReply(sourceDS: dataStore!, destinationDS: &destinationDS)
        navigateToCreatePromptReply(source: viewController!, destination: destinationVC)
    }
    
    func passDataToCreatePromptReply(sourceDS: PromptDetailDataStore, destinationDS: inout CreatePromptReplyDataStore) {
        destinationDS.prompt = sourceDS.prompt
    }
    
    func navigateToCreatePromptReply(source: PromptDetailViewController, destination: CreatePromptReplyViewController) {
        source.present(destination, animated: true, completion: nil)
    }
    
}
