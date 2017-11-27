
import Foundation
import UIKit
import SnapKit
import SwiftGifOrigin
import Kingfisher
import SwiftyGif

class GIFCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = "GIFCollectionCell"
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: Imageable) {
        if let url = URL(string: image.urlString) {
            imageView.kf.indicatorType = .activity
            UIView.animate(withDuration: 0.5, animations: {
                self.imageView.kf.setImage(with: url)
            })
        }
    }
    
    fileprivate func setupImageView() {
        imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
}


