
import Foundation
import UIKit

@objc protocol SelectGIFRoutingLogic {
    func routeToCreatePrompt()
}

class SelectGIFRouter: NSObject, SelectGIFRoutingLogic {
    
    weak var viewController: SelectGIFViewController?
    
    // MARK: Routing
    func routeToCreatePrompt() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
}
