
import Foundation
import UIKit

struct OnboardingPageInfo {
    var id: Int
    var headerString: String
    var bodyString: String
    var buttonTitle: String
}

final class OnboardingScrollViewController: UIViewController {
    
    fileprivate var viewModel: OnboardingScrollViewModel!
    fileprivate var scrollView: UIScrollView!
    fileprivate var onboardingViews = [OnboardingView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = OnboardingScrollViewModel()
        setupScrollView()
        createViewsWith(viewModel.pageInfo)
        configureScrollViewWith(onboardingViews)
    }
    
}

extension OnboardingScrollViewController {
    
    func didSelectNextButton(_ sender: UIButton) {
        let offset = scrollView.contentOffset
        let maxX = view.frame.width * CGFloat(onboardingViews.count - 1)
        guard maxX != offset.x else { //TODO: Display Login
            return }
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.x = offset.x + self.view.frame.width
        }
    }
    
}

extension OnboardingScrollViewController {
    
    fileprivate func createViewsWith(_ pageInfo: [OnboardingPageInfo]) {
        pageInfo.forEach { (info) in
            let view = OnboardingView()
            configureViewWith(info, view: view)
            onboardingViews.append(view)
        }
    }
    
    fileprivate func configureViewWith(_ info: OnboardingPageInfo, view: OnboardingView) {
        view.headerLabel.text = info.headerString
        view.button.addTarget(self, action: #selector(didSelectNextButton), for: .touchUpInside)
    }

}

extension OnboardingScrollViewController {
    
    fileprivate func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.constrainEdges(to: view)
    }
    
    fileprivate func configureScrollViewWith<T:UIView>(_ views: [T]) {
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(onboardingViews.count), height: view.frame.height)
        
        for i in 0..<onboardingViews.count {
            onboardingViews[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(onboardingViews[i])
        }
    }
    
}
