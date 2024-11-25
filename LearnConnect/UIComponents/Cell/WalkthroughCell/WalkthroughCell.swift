//
//  WalkthroughCell.swift
//  LearnConnect
//
//  Created by Melih Avcı on 25.11.2024.
//

import UIKit

public class WalkthroughCell: UICollectionViewCell, ReusableView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0 
        label.textColor = .appCinder
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .appRaven
        return label
    }()
    
    var viewModel: WalkthroughCellProtocol?

    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
    }
}

// MARK: - UILayout
extension WalkthroughCell {
    
    private func addSubviews() {
        addImageView()
        addContainerView()
        contentView.backgroundColor = .appWhite
    }
    
    private func addImageView() {
        contentView.addSubview(imageView)
        imageView.edgesToSuperview(excluding: .bottom, insets: UIEdgeInsets(top: 200, left: 50, bottom: 0, right: 50))
        imageView.centerYToSuperview()
        imageView.aspectRatio(1)
    }
    
    private func addContainerView() {
        contentView.addSubview(containerView)
        containerView.topToBottom(of: imageView)
        containerView.edgesToSuperview(excluding: .top)
        
        containerView.addSubview(labelStackView)
        
        labelStackView.centerYToSuperview()
        labelStackView.leadingToSuperview().constant = 50
        labelStackView.trailingToSuperview().constant = -50
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
    }
}

// MARK: - SetViewModel
extension WalkthroughCell {

    public func set(viewModel: WalkthroughCellProtocol) {
        self.viewModel = viewModel
        self.imageView.image = viewModel.image
        self.titleLabel.text = viewModel.titleLabel
        self.descriptionLabel.text = viewModel.descriptionLabel
    }
}
