
import Foundation
import UIKit
import SnapKit

final class SelectGIFViewController: UIViewController {
    
    var gifSearchVC: GIFSearchViewController!
    var headerView: UIView!
    var backButton: UIButton!
    var doneButton: UIButton!
    var didSelectImage: ((Imageable) -> Void)?
    
    var router:
    (SelectGIFRoutingLogic &
    NSObjectProtocol)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let router = SelectGIFRouter()
        viewController.router = router
        router.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        self.navigationController?.isNavigationBarHidden = false
        setupHeaderView()
        setupChildGIFSearchViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }

    func didSelectBackButton(_ sender: UIButton) {
        router?.routeToCreatePrompt()
    }
    
    func didSelectDoneButton(_ sender: UIButton) {
        router?.routeToCreatePrompt()
    }

    deinit {
        print("Selected GIF deinit")
    }
    
}

extension SelectGIFViewController: GIFSearchControllerDelegate {
    
    func didSelectImage(_ image: Imageable) {
        self.didSelectImage?(image)
    }
    
}

extension SelectGIFViewController {
    
    fileprivate func setupChildGIFSearchViewController() {
        gifSearchVC = GIFSearchViewController()
        gifSearchVC.delegate = self
        self.addGIFSearch(asChildViewController: gifSearchVC)
        
        gifSearchVC.view.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.top.equalTo(headerView.snp.bottom)
        }
    }

    fileprivate func setupHeaderView() {
        headerView = UIView()
        headerView.backgroundColor = UIColor.orange
        
        backButton = UIButton()
        backButton.setTitle("Back", for: .normal)
        backButton.sizeToFit()
        backButton.addTarget(self, action: #selector(didSelectBackButton), for: .touchUpInside)
        
        doneButton = UIButton()
        doneButton.setTitle("Done", for: .normal)
        doneButton.sizeToFit()
        doneButton.addTarget(self, action: #selector(didSelectDoneButton), for: .touchUpInside)
        
        headerView.addSubview(backButton)
        headerView.addSubview(doneButton)
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(headerView).offset(20)
            make.centerY.equalTo(headerView)
        }
        
        doneButton.snp.makeConstraints { (make) in
            make.right.equalTo(headerView).offset(-20)
            make.centerY.equalTo(headerView)
        }
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.height.equalTo(70)
        }
    }
 
}

extension SelectGIFViewController {
    
    fileprivate func addGIFSearch(asChildViewController viewController: UIViewController) {
        addChildViewController(viewController)
        view.addSubview(viewController.view)
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
    }
    
}
