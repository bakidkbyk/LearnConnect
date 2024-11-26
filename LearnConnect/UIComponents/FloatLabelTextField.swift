//
//  FloatLabelTextField.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

import UIKit

public class FloatLabelTextField: UITextField {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.layer.borderColor = UIColor.gray.cgColor
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var insets: UIEdgeInsets {
       var insets = UIEdgeInsets(top: 29, left: 15, bottom: 12, right: 15)
        if let leftView = leftView {
            insets.left += leftView.frame.width + 10
        }
        return insets
    }
    
    public var title: String? {
        willSet {
            placeholder = nil
            attributedPlaceholder = nil
            titleLabel.text = newValue
            titleLabel.sizeToFit()
        }
    }
    
    public var leftImage: UIImage? {
        willSet {
            if let image = newValue {
                imageView.image = image.withRenderingMode(.alwaysTemplate)
                leftView = imageView
                leftViewMode = .always
            } else {
                imageView.image = nil
                leftView = nil
                leftViewMode = .never
            }
        }
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: insets)
    }
    
    public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x = 15
        rect.origin.y = 21
        return rect
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureContents()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        placeholder = nil
        attributedPlaceholder = nil
        setTitlePosition()
        if isFirstResponder || !text!.isEmpty {
            setTitleToTop(animate: true)
            layer.borderColor = UIColor.red.cgColor
        } else {
            setTitleToCenter(animate: true)
            layer.borderColor = UIColor.gray.cgColor
        }
    }
}

// MARK: - ConfigureContents - SetTitle
extension FloatLabelTextField {
    
    private func configureContents() {
        addSubview(titleLabel)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        borderStyle = .none
        layer.borderWidth = 2
        layer.cornerRadius = 4
    }
    
    private func setTitlePosition() {
        titleLabel.frame.origin.x = insets.left
        titleLabel.frame.size.width = frame.size.width - insets.left - insets.right
    }
    
    private func configureTitleForTop() {
        let contentHeight = frame.size.height
        let titleHeight = titleLabel.frame.size.height
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .red
        titleLabel.frame.origin.y = (contentHeight / 2) - titleHeight
    }
    
    private func configureTitleForCenter() {
        let contentHeight = frame.size.height
        let titleHeight = titleLabel.frame.size.height
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .gray
        titleLabel.frame.origin.y = (contentHeight / 2) - (titleHeight / 2 )
    }
    
    private func setTitleToTop(animate: Bool) {
        guard animate else { return }
        UIView.animate(withDuration: 0.25, delay: 0, options: [.beginFromCurrentState, .curveEaseIn], animations: { [ weak self ] in
            self?.configureTitleForTop()
        }, completion: nil)
    }
    
    private func setTitleToCenter(animate: Bool) {
        guard animate else { return }
        UIView.animate(withDuration: 0.25, delay: 0, options: [.beginFromCurrentState, .curveEaseIn], animations: { [ weak self ] in
            self?.configureTitleForCenter()
        }, completion: nil)
    }
}

