
import Foundation
import UIKit

class OnboardingView: UIView {
    
    var backgroundView: UIView!
    var headerLabel: UILabel!
    var button: UIButton!
    
    init() {
        super.init(frame: .zero)
        setupBackgroundView()
        setupHeaderLabel()
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewInfo: OnboardingPageInfo? {
        didSet {
            headerLabel.text = viewInfo?.headerString
        }
    }
    
    private func setupBackgroundView() {
        backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.red
        
        self.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.constrainEdges(to: self)
    }
    
    private func setupHeaderLabel() {
        headerLabel = UILabel()
        
        backgroundView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.center(in: backgroundView)
    }
    
    private func setupButton() {
        button = UIButton()
        button.backgroundColor = UIColor.blue
        
        backgroundView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10).isActive = true
        button.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}

extension UIView {
    
    func constrainEdges(to view: UIView) {
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    func center(in view: UIView) {
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
