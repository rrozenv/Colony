
import Foundation
import UIKit

@objc protocol CreatePromptRoutingLogic {
    func routeToHome()
}

//protocol ListShowtimesDataPassing {
//    var dataStore: ListShowtimesDataStore? { get }
//}

class CreatePromptRouter: NSObject, CreatePromptRoutingLogic {
   
    weak var viewController: CreatePromptViewController?
    //var dataStore: ListShowtimesDataStore?
    
    // MARK: Routing
    func routeToHome() {
//        let index = viewController!.navigationController!.viewControllers.count - 2
//        let destinationVC = viewController?.navigationController?.viewControllers[index] as! HomeViewController
        navigateToHome()
    }
    
    func navigateToHome() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
}
