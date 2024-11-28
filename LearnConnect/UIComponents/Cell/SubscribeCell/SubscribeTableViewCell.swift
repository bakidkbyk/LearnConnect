//
//  SubscribeTableViewCell.swift
//  LearnConnect
//
//  Created by Melih Avcı on 26.11.2024.
//

import UIKit

public class SubscribeTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .appCinder
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    var viewModel: SubscribeTableViewCellModelProtocol?
    
    var buttonAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        setupButtonAction()
    }
    
    private func setupButtonAction() {
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        buttonAction?()
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}

// MARK: - UI Layout
extension SubscribeTableViewCell {

    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.edgesToSuperview(insets: .horizontal(16))

        containerView.addSubview(stackView)
        stackView.edgesToSuperview(insets: .vertical(8))

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(button)

        button.size(CGSize(width: 10, height: 10))
    }
}

// MARK: - Set ViewModel
extension SubscribeTableViewCell {
    public func set(viewModel: SubscribeTableViewCellModelProtocol) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.titleLabel
    }
}
