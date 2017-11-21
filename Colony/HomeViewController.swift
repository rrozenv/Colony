
import Foundation
import UIKit
import CoreLocation
import SnapKit

class HomeViewController: UIViewController {
    
    enum CurrentScreen {
        case prompts
        case categories
        case profile
    }
    
    fileprivate var currentViewController: UIViewController!
    fileprivate var currentScreen: CurrentScreen
    
    fileprivate var backgroundViewForStatusBar: UIView!
    fileprivate var customNavBar: CustomNavigationBar!
    
    fileprivate lazy var promptsViewController: PromptsListViewController = { [unowned self] in
        let vc = PromptsListViewController()
//        vc.collectionViewTopInset = self.customNavBar.height + self.tabBarView.height + 20
        return vc
    }()
    
    var engine: HomeBusinessLogic?
    var router: (NSObjectProtocol)?
    
    init(currentScreen: HomeViewController.CurrentScreen) {
        self.currentScreen = currentScreen
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let viewController = self
        let engine = HomeEngine()
        let router = HomeRouter()
        viewController.engine = engine
        viewController.router = router
        //router.viewController = viewController
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        setupBackgroundViewForStatusBar()
        setupCustomNavigationBar()
        setCurrentViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    fileprivate func setCurrentViewController() {
        switch currentScreen {
        case .prompts:
            currentViewController = promptsViewController
        case .categories:
            break
        case .profile:
            break
        }
        self.add(asChildViewController: currentViewController)
    }
 
}

//MARK: - Tab Bar Item Selected Functions

extension HomeViewController {
    
//    @objc fileprivate func didSelectLeftButton(_ sender: UIButton) {
//        guard currentTabButton != .categories else { return }
//        self.currentTabButton = .categories
//        self.switchViewController(for: self.currentTabButton)
//    }
//
//    @objc fileprivate func didSelectRightButton(_ sender: UIButton) {
//        guard currentTabButton != .profile else { return }
//        self.currentTabButton = .profile
//        self.switchViewController(for: self.currentTabButton)
//    }
    
}

//MARK: - Switch View Controller Functions

extension HomeViewController {
    
    fileprivate func switchViewController(for tabBarItem: CurrentScreen) {
        switch currentScreen {
        case .prompts:
            switchTo(promptsViewController)
        case .categories:
            break
        case .profile:
            break
        }
    }
    
    fileprivate func switchTo(_ viewController: UIViewController) {
        guard let currentViewController = self.currentViewController else { return }
        self.remove(asChildViewController: currentViewController)
        self.add(asChildViewController: viewController)
    }
    
    fileprivate func add(asChildViewController viewController: UIViewController) {
        addChildViewController(viewController)
        view.insertSubview(viewController.view, belowSubview: customNavBar)
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.constrainEdges(to: self.view)
    }
    
    fileprivate func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
}

//MARK: - View Setup

extension HomeViewController {
    
    func setupBackgroundViewForStatusBar() {
        backgroundViewForStatusBar = UIView()
        backgroundViewForStatusBar.backgroundColor = UIColor.white
        
        view.addSubview(backgroundViewForStatusBar)
        backgroundViewForStatusBar.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(view)
            make.height.equalTo(20)
        }
    }
    
    func setupCustomNavigationBar() {
        customNavBar = CustomNavigationBar(leftImage: nil, centerImage: nil, rightImage: nil)
//        customNavBar.rightButton.addTarget(self, action: #selector(didSelectSettingsButton), for: .touchUpInside)
//        customNavBar.centerButton.addTarget(self, action: #selector(didSelectPostalCode), for: .touchUpInside)
        
        view.insertSubview(customNavBar, belowSubview: backgroundViewForStatusBar)
        customNavBar.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(view).offset(20)
            make.height.equalTo(customNavBar.height)
        }
    }
    
}



