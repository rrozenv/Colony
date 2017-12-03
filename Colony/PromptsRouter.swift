
import UIKit

@objc protocol PromptsRoutingLogic {
    func routeToPromptDetail()
}

protocol PromptsDataPassing {
    var dataStore: PromptsListDataStore? { get }
}

class PromptsRouter: NSObject, PromptsRoutingLogic, PromptsDataPassing {
    
    weak var viewController: PromptsListViewController?
    var dataStore: PromptsListDataStore?
  
    // MARK: Routing
    func routeToPromptDetail() {
        let destinationVC = PromptDetailViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToPromptDetail(sourceDS: dataStore!, destinationDS: &destinationDS)
        navigateToPromptDetail(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Passing data
    func passDataToPromptDetail(sourceDS: PromptsListDataStore, destinationDS: inout PromptDetailDataStore) {
        let selectedRow = viewController?.state.selectedRow!
        let selectedPrompt = sourceDS.prompts[selectedRow!]
        //destinationDS.prompt = selectedPrompt
    }
    
    // MARK: Navigation
    func navigateToPromptDetail(source: PromptsListViewController, destination: PromptDetailViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
}


