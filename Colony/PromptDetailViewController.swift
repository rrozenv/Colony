
import Foundation
import UIKit

protocol PromptDetailDisplayLogic: class {
    func displayPromptReplies(viewModel: PromptDetail.FetchPromptReplies.ViewModel)
}

final class PromptDetailViewController: UIViewController {
    
    var tableView: UITableView!
    var displayedReplies = [DisplayedReply]()
    var createReplyButton: UIButton!

    var engine: PromptDetailLogic?
    var router:
    (PromptDetailRoutingLogic &
    PromptDetailDataPassing &
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
        let engine = PromptDetailEngine()
        let formatter = PromptDetailFormatter()
        let router = PromptDetailRouter()
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

extension PromptDetailViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        setupTableView()
        setupCreatePromptReplyButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        fetchPromptReplies()
    }
    
    func didSelectCreateReplyButton(_ sender: UIButton) {
        router?.routeToCreatePromptReply()
    }
    
}

// MARK: - Output

extension PromptDetailViewController {
    
    func fetchPromptReplies() {
        guard let userDidReply = engine?.checkIfUserReplied(), userDidReply else {
            print("User has not replied yet.") ; return
        }
        let request = PromptDetail.FetchPromptReplies.Request()
        engine?.fetchPromptReplies(request: request)
    }
    
}

extension PromptDetailViewController: PromptTableCellDelegate {
    
    func didSelectScore(_ score: String, replyId: String) {
        let request = PromptDetail.SaveUserScoreForReply.Request(replyId: replyId, score: score)
        engine?.saveUserCastedScore(request: request)
    }
    
}

// MARK: - Formatter Input

extension PromptDetailViewController: PromptDetailDisplayLogic {
    
    func displayPromptReplies(viewModel: PromptDetail.FetchPromptReplies.ViewModel) {
        //state.isLoading = false
        self.displayedReplies = viewModel.replies
        self.tableView.reloadData()
    }
    
}

//MARK: - View Setup

extension PromptDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedReplies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PromptReplyTableCell.reuseIdentifier, for: indexPath) as? PromptReplyTableCell else { fatalError() }
        if cell.delegate == nil { cell.delegate = self }
        let reply = self.displayedReplies[indexPath.row]
        cell.configure(with: reply)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension PromptDetailViewController {
    
    fileprivate func setupTableView() {
        //MARK: - tableView Properties
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.register(PromptReplyTableCell.self, forCellReuseIdentifier: PromptReplyTableCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //MARK: - tableView Constraints
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    fileprivate func setupCreatePromptReplyButton() {
        //MARK: - createPromptButton Properties
        createReplyButton = UIButton()
        createReplyButton.backgroundColor = UIColor.black
        createReplyButton.titleLabel?.font = FontBook.AvenirHeavy.of(size: 13)
        createReplyButton.setTitle("Reply", for: .normal)
        createReplyButton.addTarget(self, action: #selector(didSelectCreateReplyButton), for: .touchUpInside)
        
        //MARK: - createPromptButton Constraints
        view.addSubview(createReplyButton)
        createReplyButton.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(60)
        }
    }
    
    
}
