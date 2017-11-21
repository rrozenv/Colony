
import Foundation
import UIKit

struct Screen {
    static let height = UIScreen.main.bounds.height
    static let width = UIScreen.main.bounds.width
}

struct Device {
    static let height = UIScreen.main.bounds.height
    static let width = UIScreen.main.bounds.width
}

final class CustomNavigationBar: UIView {
    
    //MARK: View Properties
    private let height1X: CGFloat = 75.0
    var containerView: UIView!
    var leftButton: UIButton!
    var centerButton: UIButton!
    var rightButton: UIButton!
    var locationLabel: UILabel!
    var height: CGFloat {
        return Screen.height * (height1X / Screen.height)
    }
    
    //MARK: Initalizer Setup
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(leftImage: UIImage?, centerImage: UIImage?, rightImage: UIImage?) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.clear
        setupBackgroundView()
        setupLeftButton(with: leftImage)
        setupCenterButton(with: centerImage)
        setupRightButton(with: rightImage)
        setupLocationLabel()
    }
    
}

extension CustomNavigationBar {
    
    fileprivate func setupBackgroundView() {
        containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.layer.masksToBounds = true
        
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.constrainEdges(to: self)
    }
    
    fileprivate func setupLeftButton(with image: UIImage?) {
        leftButton = UIButton()
        leftButton.backgroundColor = UIColor.clear
        leftButton.setImage(image, for: .normal)
        
        containerView.addSubview(leftButton)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.064).isActive = true
        leftButton.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.064).isActive = true
        leftButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        leftButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
    
    fileprivate func setupCenterButton(with image: UIImage?) {
        centerButton = UIButton()
        centerButton.backgroundColor = UIColor.clear
        centerButton.setImage(image, for: .normal)
        
        containerView.addSubview(centerButton)
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        centerButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.2267).isActive = true
        centerButton.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.1786).isActive = true
        centerButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        centerButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 3).isActive = true
    }
    
    fileprivate func setupRightButton(with image: UIImage?) {
        rightButton = UIButton()
        rightButton.backgroundColor = UIColor.clear
        rightButton.setImage(image, for: .normal)
        
        containerView.addSubview(rightButton)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.060).isActive = true
        rightButton.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.068).isActive = true
        rightButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        rightButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
    
    fileprivate func setupLocationLabel() {
        locationLabel = UILabel()
        locationLabel.textColor = UIColor.yellow
        locationLabel.font = FontBook.AvenirHeavy.of(size: 13)
        
        containerView.insertSubview(locationLabel, aboveSubview: centerButton)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.centerXAnchor.constraint(equalTo: centerButton.centerXAnchor, constant: 5).isActive = true
        locationLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -6).isActive = true
    }
    
}
