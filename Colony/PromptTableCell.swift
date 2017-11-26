
import Foundation
import UIKit

final class PromptTableCell: UITableViewCell {
    
    // MARK: - Type Properties
    static let reuseIdentifier = "PromptTableCell"
  
    // MARK: - Properties
    fileprivate var promptView: PromptView!
    
    // MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func commonInit() {
        self.contentView.backgroundColor = UIColor.white
        self.separatorInset = .zero
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = .zero
        setupPromptView()
    }
    
    func configure(with prompt: DisplayedPrompt) {
        promptView.titleLabel.text = prompt.title
        promptView.replyTextLabel.text = "replies"
        promptView.replyCountLabel.text = "10"
    }
    
    override func prepareForReuse() { }
    
}

//MARK: Constraints Setup

extension PromptTableCell {
    
    func setupPromptView() {
        promptView = PromptView()
        
        contentView.addSubview(promptView)
        promptView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView).inset(UIEdgeInsetsMake(20, 20, 10, 20))
        }
    }

}
