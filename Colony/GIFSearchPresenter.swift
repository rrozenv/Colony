
import Foundation
import UIKit

protocol GIFSearchPresentationLogic {
    func formatGIFS(response: GIFSearch.Response)
}

class GIFSearchPresenter: GIFSearchPresentationLogic {
    
    weak var viewController: GIFSearchViewController?
    
    func formatGIFS(response: GIFSearch.Response) {
        guard let images = response.images else {
            return
            //viewController?.displayErrror
        }
        let viewModel = GIFSearch.ViewModel(displayedImages: images)
        viewController?.displayGIFS(viewModel: viewModel)
    }
    
}
