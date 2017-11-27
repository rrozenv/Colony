
import Foundation
import UIKit
import SnapKit

protocol GIFSearchControllerDelegate: class {
    func didSelectGIF(_ gif: GIF)
}

protocol GIFSDisplayLogic: class {
    func displayGIFS(viewModel: GIFSearch.ViewModel)
}

final class GIFSearchViewController: UIViewController, GIFSDisplayLogic {
    
    var searchTextField: SearchTextField!
    var searchIcon: UIImageView!
    var clearSearchButton: UIButton!
    
    var collectionView: UICollectionView!
    var collectionViewGridLayout: UICollectionViewFlowLayout!
    var displayedGIFS = [GIF]()
    
    var engine: GIFSearchLogic?
    weak var delegate: GIFSearchControllerDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let engine = GIFSearchEngine()
        let presenter = GIFSearchPresenter()
        viewController.engine = engine
        engine.presenter = presenter
        presenter.viewController = viewController
    }

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor.white
        setupSearchTextfield()
        setupSearchTextFieldCallback()
        setupSearchTextFieldConstraints()
        setupSearchIcon()
        setupClearSearchButton()
        setupCollectionView()
    }
    
    deinit {
        print("Search Controller deinit")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: Output
    
    func createRequestWithSearch(query: String) {
        let request = GIFSearch.Request(query: query)
        engine?.makeQuery(request: request)
    }
    
    fileprivate func setupSearchTextFieldCallback() {
        searchTextField.onSearch = { [unowned self] searchText in
            self.shouldDisplayClearSearchButton(searchText)
            let shouldNotSearch = (0...2).contains(searchText.count)
            //let shouldNotSearch = 0...3 ~= searchText.characters.count
            if shouldNotSearch {
                self.displayedGIFS = [GIF]()
                self.collectionView.reloadData()
            } else {
                self.createRequestWithSearch(query: searchText)
            }
        }
    }
    
    fileprivate func shouldDisplayClearSearchButton(_ searchText: String) {
        guard !searchText.isEmpty && searchText != "" else {
            clearSearchButton.isHidden = true
            return
        }
        clearSearchButton.isHidden = false
    }
    
    func didTapClearSearch(_ sender: UIButton) {
        self.searchTextField.text = nil
        self.shouldDisplayClearSearchButton("")
        self.displayedGIFS = [GIF]()
        self.collectionView.reloadData()
    }
    
    //MARK: Input
    
    func displayGIFS(viewModel: GIFSearch.ViewModel) {
        self.displayedGIFS = viewModel.displayedGIFS
        self.collectionView.reloadData()
    }

}


extension GIFSearchViewController {
    
    fileprivate func setupSearchTextfield() {
        searchTextField = SearchTextField()
        searchTextField.throttlingInterval = 0.5
        searchTextField.placeholder = "Search movies..."
        searchTextField.backgroundColor = UIColor.white
        searchTextField.layer.cornerRadius = 4.0
        searchTextField.layer.masksToBounds = true
        searchTextField.font = FontBook.AvenirMedium.of(size: 14)
        searchTextField.textColor = UIColor.black
    }
    
    fileprivate func setupSearchTextFieldConstraints() {
        self.view.addSubview(searchTextField)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        searchTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.11).isActive = true
    }
    
    fileprivate func setupSearchIcon() {
        searchIcon = UIImageView(image: #imageLiteral(resourceName: "IC_Search"))
        
        self.view.addSubview(searchIcon)
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.widthAnchor.constraint(equalToConstant: Screen.width * 0.048).isActive = true
        searchIcon.heightAnchor.constraint(equalToConstant: Screen.width * 0.048).isActive = true
        searchIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        searchIcon.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor, constant: -2).isActive = true
    }
    
    fileprivate func setupClearSearchButton() {
        clearSearchButton = UIButton()
        clearSearchButton.addTarget(self, action: #selector(didTapClearSearch), for: .touchUpInside)
        clearSearchButton.backgroundColor = UIColor.brown
        clearSearchButton.isHidden = true
        
        self.view.addSubview(clearSearchButton)
        clearSearchButton.translatesAutoresizingMaskIntoConstraints = false
        clearSearchButton.widthAnchor.constraint(equalToConstant: Screen.width * 0.064).isActive = true
        clearSearchButton.heightAnchor.constraint(equalToConstant: Screen.width * 0.064).isActive = true
        clearSearchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        clearSearchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor).isActive = true
    }

}

extension GIFSearchViewController {
    
    fileprivate func setupCollectionView() {
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: GIFGridLayout(topInset: 20))
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MainMovieListCell.self, forCellWithReuseIdentifier: MainMovieListCell.reuseIdentifier)
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(searchTextField.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
    
}

extension GIFSearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedGIFS.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainMovieListCell.reuseIdentifier, for: indexPath) as! MainMovieListCell
        cell.titleLabel.text = displayedGIFS[indexPath.item].url
        return cell
    }
    
}

extension GIFSearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gif = self.displayedGIFS[indexPath.row]
        delegate?.didSelectGIF(gif)
        
    }
    
}

