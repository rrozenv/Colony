
import Foundation
import UIKit

@objc protocol HomeRoutingLogic {
    func routeToProfile()
    func routeToCreatePrompt()
//    func routeToLocationSearch()
    //func routeToMovieSearch()
}

class HomeRouter: NSObject, HomeRoutingLogic {
    
    weak var viewController: HomeViewController?
    
    // MARK: Routing
    func routeToProfile() {
        let destinationVC = SettingsViewController()
        navigateToSettings(source: viewController!, destination: destinationVC)
    }
    
    func routeToCreatePrompt() {
        let destinationVC = CreatePromptViewController()
        navigateTo(destination: destinationVC, from: viewController!)
    }
//
//    func routeToLocationSearch() {
//        let destinationVC = LocationSearchViewController()
//        navigateToLocationSearch(source: viewController!, destination: destinationVC)
//    }
    
//    func routeToMovieSearch() {
//        let rootController = SelectMoviesViewController()
//        let destinationVC = UINavigationController(rootViewController: rootController)
//        navigateToMovieSearch(source: viewController!, destination: destinationVC)
//    }
//    
    // MARK: Navigation
    
    func navigateTo(destination: UIViewController, from source: UIViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    func navigateToSettings(source: HomeViewController, destination: SettingsViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
//
//    func navigateToLocationSearch(source: HomeViewController, destination: LocationSearchViewController) {
//        source.navigationController?.pushViewController(destination, animated: true)
//    }
    
//    func navigateToMovieSearch(source: MainMovieListViewController, destination: UINavigationController) {
//        source.present(destination, animated: true, completion: nil)
//    }
    
}
