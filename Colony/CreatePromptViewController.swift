
import Foundation
import UIKit

final class CreatePromptViewController: UIViewController {
    
    var bodyTextView: UITextView!
    var titleTextView: UITextView!
    var addGIFButton: UIButton!
    
    var engine: CreatePromptLogic?
    var router:
    (CreatePromptRoutingLogic &
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
        let engine = CreatePromptEngine()
        //let presenter = SelectMoviesPresenter()
        let router = CreatePromptRouter()
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
        self.navigationController?.isNavigationBarHidden = false
        setupTitleTextView()
        setupBodyTextView()
        setupAddGIFButton()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didSelectPostButton))
        titleTextView.becomeFirstResponder()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    deinit {
        print("Create Prompt deinit")
    }
    
    func didSelectPostButton(_ sender: UIBarButtonItem) {
        let request = CreatePrompt.Create.Request(title: titleTextView.text, body: bodyTextView.text)
        engine?.createPrompt(request: request, completion: { (result) in
            switch result {
            case .success:
                self.router?.routeToHome()
            case .missingGIF:
                print("GIF missing!")
            default:
                print("no success")
            }
        })
    }
    
    func didSelectAddGIF(_ sender: UIButton) {
        router?.routeToSelectGIF()
    }
    
    func setupTitleTextView() {
        titleTextView = UITextView()
        titleTextView.delegate = self
        titleTextView.font = FontBook.AvenirHeavy.of(size: 14)
        titleTextView.isEditable = true
        titleTextView.isScrollEnabled = false
        titleTextView.backgroundColor = UIColor.yellow
        titleTextView.text = "Title"
        
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
    
    func setupAddGIFButton() {
        addGIFButton = UIButton()
        addGIFButton.backgroundColor = UIColor.blue
        addGIFButton.setTitle("Post", for: .normal)
        addGIFButton.addTarget(self, action: #selector(didSelectAddGIF), for: .touchUpInside)
        
        view.addSubview(addGIFButton)
        addGIFButton.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(bodyTextView.snp.bottom).offset(10)
        }
    }
    
}

extension CreatePromptViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {

    }
    
}

