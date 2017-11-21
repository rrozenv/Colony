
import UIKit
import Foundation
import RealmSwift
import PromiseKit
import SnapKit

// MARK: - Initialization

protocol PromptsDisplayLogic: class {
    func displayPrompts(viewModel: Prompts.FetchPrompts.ViewModel)
}

final class PromptsListViewController: UIViewController {
    
    struct State {
        var isLoading: Bool = false
        var selectedRow: Int?
    }
    
    var tableView: UITableView!
    var displayedPrompts = [DisplayedPrompt]()
    
    //var collectionViewTopInset: CGFloat?
    var createPromptButton: UIButton!

//    var state: State = State() {
//        didSet {
//            if state.isLoading {
//                loadingIndicator.startAnimating()
//            } else {
//                loadingIndicator.stopAnimating()
//            }
//        }
//    }

    var engine: PromptsListBusinessLogic?
//    var router:
//        ( &
//         MainMovieListDataPassing &
//         NSObjectProtocol)?
    
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
        let engine = PromptsListEngine()
        let formatter = PromptsFormatter()
        //let router = MainMovieListRouter()
        viewController.engine = engine
        //viewController.router = router
        engine.formatter = formatter
        formatter.viewController = viewController
//        router.viewController = viewController
//        router.dataStore = interactor
    }
    
    deinit {
        print("Main Movie list is deiniting")
    }
  
}

// MARK: - View Life Cycle

extension PromptsListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        setupTableView()
        setupCreatePromptButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
}

// MARK: - Output

extension PromptsListViewController {
    
    func fetchPrompts() {
        let request = Prompts.FetchPrompts.Request()
        engine?.fetchPrompts(request: request)
    }
    
}

// MARK: - Presenter Input

extension PromptsListViewController: PromptsDisplayLogic {
    
    func displayPrompts(viewModel: Prompts.FetchPrompts.ViewModel) {
        //state.isLoading = false
        self.displayedPrompts = viewModel.prompts
    }
    
}

//MARK: - View Setup

extension PromptsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedPrompts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        let prompt = self.displayedPrompts[indexPath.row]
        cell.textLabel?.text = prompt.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension PromptsListViewController {
    
    fileprivate func setupTableView() {
        //MARK: - tableView Properties
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LocationCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        //MARK: - tableView Constraints
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    fileprivate func setupCreatePromptButton() {
        //MARK: - createPromptButton Properties
        createPromptButton = UIButton()
        createPromptButton.backgroundColor = UIColor.black
        createPromptButton.titleLabel?.font = FontBook.AvenirHeavy.of(size: 13)
        createPromptButton.setTitle("Create Prompt", for: .normal)
//        createPromptButton.addTarget(self, action: #selector(didSelectMovieSearchButton), for: .touchUpInside)
        
        //MARK: - createPromptButton Constraints
        view.addSubview(createPromptButton)
        createPromptButton.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(60)
        }
    }
    
}
