
import Foundation
import UIKit

@objc protocol SelectGIFRoutingLogic {
    func routeToCreatePrompt()
}

protocol SelectGIFDataPassing {
    var dataStore: SelectGIFDataStore? { get }
}

class SelectGIFRouter: NSObject, SelectGIFRoutingLogic, SelectGIFDataPassing {
    
    weak var viewController: SelectGIFViewController?
    var dataStore: SelectGIFDataStore?
    
    // MARK: Routing
    func routeToCreatePrompt() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
}
