
import Foundation
import UIKit

final class CreatePromptReplyViewController: UIViewController {
    
    var postButton: UIButton!
    var bodyTextView: UITextView!
    var titleTextView: UITextView!
    var engine: CreatePromptReplyLogic?
    var router:
    (CreatePromptReplyRoutingLogic & CreatePromptReplyDataPassing &
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
        let engine = CreatePromptReplyEngine()
        //let presenter = SelectMoviesPresenter()
        let router = CreatePromptReplyRouter()
        viewController.engine = engine
        viewController.router = router
        //        engine.presenter = presenter
        //        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = engine
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        setupTitleTextView()
        setupBodyTextView()
        setupPostButton()
        bodyTextView.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    deinit {
        print("Create Prompt deinit")
    }
    
    func didSelectPostButton(_ sender: UIButton) {
        let request = CreatePromptReply.Create.Request(body: bodyTextView.text)
        engine?.createPrompt(request: request, completion: { [weak self] (isSuccess) in
            print(isSuccess)
            self?.router?.routeToPromptDetail()
        })
    }
    
    func setupTitleTextView() {
        titleTextView = UITextView()
        titleTextView.delegate = self
        titleTextView.font = FontBook.AvenirHeavy.of(size: 14)
        titleTextView.isEditable = false
        titleTextView.isScrollEnabled = false
        titleTextView.backgroundColor = UIColor.yellow
        titleTextView.text = engine?.promptTitle
        
        view.addSubview(titleTextView)
        titleTextView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(10)
        }
    }
    
    func setupBodyTextView() {
        bodyTextView = UITextView()
        bodyTextView.delegate = self
        bodyTextView.font = FontBook.AvenirHeavy.of(size: 14)
        bodyTextView.isEditable = true
        bodyTextView.isScrollEnabled = false
        bodyTextView.backgroundColor = UIColor.yellow
        bodyTextView.text = "body"
        
        view.addSubview(bodyTextView)
        bodyTextView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(titleTextView.snp.bottom).offset(10)
        }
    }
    
    func setupPostButton() {
        postButton = UIButton()
        postButton.backgroundColor = UIColor.blue
        postButton.setTitle("Post", for: .normal)
        postButton.addTarget(self, action: #selector(didSelectPostButton), for: .touchUpInside)
        
        view.addSubview(postButton)
        postButton.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(bodyTextView.snp.bottom).offset(10)
        }
    }
    
}

extension CreatePromptReplyViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
}
