
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
        let resource = GIF.GIFResource(for: request.query)
        webservice.load(resource).then { [weak self] (gifs) -> Void in
                self?.generateResponseForPresenter(with: gifs)
            }.catch { [weak self] (error) in
                self?.generateResponseForPresenter(with: nil)
                print(error.localizedDescription)
            }
    }
    
    fileprivate func generateResponseForPresenter(with gifs: [GIF]?) {
        let response = GIFSearch.Response(gifs: gifs ?? nil)
        self.presenter?.formatGIFS(response: response)
    }
    
}

