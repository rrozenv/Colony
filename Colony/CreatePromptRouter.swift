
import Foundation
import UIKit

@objc protocol CreatePromptRoutingLogic {
    func routeToHome()
    func routeToSelectGIF()
}

protocol CreatePrompotDataPassing {
    var dataStore: CreatePromptDataStore? { get }
}

class CreatePromptRouter: NSObject, CreatePromptRoutingLogic {
   
    weak var viewController: CreatePromptViewController?
    var dataStore: CreatePromptDataStore?
    
    // MARK: Routing
    func routeToHome() {
        navigateToHome()
    }
    
    func routeToSelectGIF() {
        let destinationVC = SelectGIFViewController()
        self.navigateToSelectGIF(source: viewController!, destination: destinationVC)
    }
    
    func navigateToHome() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToSelectGIF(source: CreatePromptViewController, destination: SelectGIFViewController) {
        source.present(destination, animated: true, completion: nil)
        destination.didSelectImage = { [weak self] (image) in
            self?.dataStore?.image = image
        }
    }
    
}
