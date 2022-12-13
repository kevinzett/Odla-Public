
import Foundation
import UIKit

final class StretchyHeader: UIView {
    public let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill

    return imageView
}()
    
    public let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "standardgreen")
        button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        return button
    }()
    
    public let buttonTwo: UIButton = {
        let buttonTwo = UIButton(type: .system)
        buttonTwo.backgroundColor = .green.withAlphaComponent(0.07)
        buttonTwo.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        return buttonTwo
    }()
    
    public let buttonThree: UIButton = {
        let buttonThree = UIButton(type: .system)
        buttonThree.backgroundColor = .green.withAlphaComponent(0.07)
        buttonThree.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        return buttonThree
    }()
    
    public let labelName: UILabel = {
        let labelName = UILabel()
        labelName.textColor = .white
        labelName.font = UIFont.systemFont(ofSize: 40.0, weight: .bold)
        
        return labelName
    }()
    
    public let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        
        return stackView
    }()
    
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    private var containerView = UIView()
    private var containerViewHeight = NSLayoutConstraint()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        createViews()
        setViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func createViews() {
        containerView.backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(labelName)
    }
    
    func setViewConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30)
        imageViewBottom.isActive = true
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, constant: +30)
        imageViewHeight.isActive = true
        imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: +20).isActive = true
        labelName.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0

        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
