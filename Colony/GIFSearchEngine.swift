
import Foundation
import PromiseKit
import RealmSwift

protocol GIFSearchLogic {
    func makeQuery(request: GIFSearch.Request)
}

final class GIFSearchEngine: GIFSearchLogic {
    
    var presenter: GIFSearchPresentationLogic?
    fileprivate let webservice = WebService.shared
    
    func makeQuery(request: GIFSearch.Request) {
        let resource = PixaImage.PixaImageResource(for: request.query)
        webservice.load(resource).then { [weak self] (images) -> Void in
                self?.generateResponseForPresenter(with: images)
            }.catch { [weak self] (error) in
                self?.generateResponseForPresenter(with: nil)
                if let httpError = error as? HTTPError {
                    print(httpError.description)
                } else {
                    print(error.localizedDescription)
                }
            }
    }
    
    fileprivate func generateResponseForPresenter(with images: [Imageable]?) {
        let response = GIFSearch.Response(images: images)
        self.presenter?.formatGIFS(response: response)
    }
    
}

