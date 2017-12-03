
import UIKit
import Foundation
import RealmSwift
import PromiseKit
import SnapKit
import RxSwift
import RxCocoa

// MARK: - Initialization

protocol PromptsDisplayLogic: class {
    var displayedPrompts: Variable<[DisplayedPrompt]>! { get set }
    //func displayPrompts(viewModel: Prompts.FetchPrompts.ViewModel)
}

final class PromptsListViewController: UIViewController {
    
    struct State {
        var isLoading: Bool = false
        var selectedRow: Int?
    }
    
    var disposeBag = DisposeBag()
    var tableView: UITableView!
    //var displayedPrompts = [DisplayedPrompt]()
    var displayedPrompts: Variable<[DisplayedPrompt]>!
    var webservice = WebService.shared
    
    //var collectionViewTopInset: CGFloat?
    var createPromptButton: UIButton!

    var state: State = State() {
        didSet {
            if state.isLoading {
                //loadingIndicator.startAnimating()
            } else {
                //loadingIndicator.stopAnimating()
            }
        }
    }

    var engine: PromptsListBusinessLogic?
    var router:
        (PromptsRoutingLogic & PromptsDataPassing &
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
        let engine = PromptsListEngine()
        let formatter = PromptsFormatter()
        let router = PromptsRouter()
        viewController.engine = engine
        viewController.router = router
        engine.formatter = formatter
        formatter.viewController = viewController
        router.viewController = viewController
        router.dataStore = engine
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
        displayedPrompts = Variable<[DisplayedPrompt]>([])
        setupTableView()
        setupTableViewBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        fetchPrompts()
    }
    
}

// MARK: - Output

extension PromptsListViewController {
    
    func fetchPrompts() {
        let request = Prompts.FetchPrompts.Request()
        engine?.fetchPrompts(request: request)
    }
    
}

// MARK: - Formatter Input

extension PromptsListViewController: PromptsDisplayLogic {
    
//    func displayPrompts(viewModel: Prompts.FetchPrompts.ViewModel) {
//        //state.isLoading = false
//        self.displayedPrompts = viewModel.prompts
//        self.tableView.reloadData()
//    }
    
    fileprivate func setupTableViewBinding() {
        self.displayedPrompts.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: PromptTableCell.reuseIdentifier, cellType: PromptTableCell.self)) {  row, prompt, cell in
                cell.configure(with: prompt)
            }
            .disposed(by: disposeBag)
    }
    
}

//MARK: - View Setup

//extension PromptsListViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return displayedPrompts.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: PromptTableCell.reuseIdentifier, for: indexPath) as? PromptTableCell else { fatalError() }
//        let prompt = self.displayedPrompts[indexPath.row]
//        cell.configure(with: prompt)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        state.selectedRow = indexPath.row
//        router?.routeToPromptDetail()
//    }
//
//}

extension PromptsListViewController {
    
    fileprivate func setupTableView() {
        //MARK: - tableView Properties
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.register(PromptTableCell.self, forCellReuseIdentifier: PromptTableCell.reuseIdentifier)
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
        //MARK: - tableView Constraints
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }

    
}
