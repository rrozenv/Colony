
import Foundation

protocol GIFSearchPresentationLogic {
    func formatGIFS(response: GIFSearch.Response)
}

class GIFSearchPresenter: GIFSearchPresentationLogic {
    
    weak var viewController: GIFSearchViewController?
    
    func formatGIFS(response: GIFSearch.Response) {
        guard let gifs = response.gifs else {
            return
            //viewController?.displayErrror
        }
        let viewModel = GIFSearch.ViewModel(displayedGIFS: gifs)
        viewController?.displayGIFS(viewModel: viewModel)
    }
    
}
