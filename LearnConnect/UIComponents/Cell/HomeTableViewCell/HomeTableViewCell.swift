//
//  HomeTableViewCell.swift
//  LearnConnect
//
//  Created by Melih Avcı on 25.11.2024.
//

import UIKit

//public class HomeTableViewCell: UITableViewCell {
//    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        label.textColor = .black
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let button: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(named: "ic_send"), for: .normal)
//        button.tintColor = .appCinder
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    var buttonAction: (() -> Void)?
//    
//    var viewModel: HomeTableViewCellProtocol?
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(button)
//        
//        NSLayoutConstraint.activate([
//            
//            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            
//            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            
//            button.widthAnchor.constraint(equalToConstant: 30),
//            button.heightAnchor.constraint(equalToConstant: 30)
//        ])
//        
//        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    @objc private func didTapButton() {
//        buttonAction?()
//    }
//    
//    func configure(title: String) {
//        titleLabel.text = title
//    }
//    
//}
//
////MARK: - UILayout
//extension HomeTableViewCell {
//    
//    private func addSubviews() {
//        
//    }
//}
//
//// MARK: - SetViewModel
//extension HomeTableViewCell {
//
//    public func set(viewModel: HomeTableViewCellProtocol) {
//        self.viewModel = viewModel
//        self.titleLabel.text = viewModel.titleLabel
//    }
//}

import UIKit

public class HomeTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_send"), for: .normal)
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
    
    var viewModel: HomeTableViewCellProtocol?
    
    var buttonAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureLayout()
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        configureLayout()
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
    
    public var title: String? {
        willSet {
            titleLabel.text = newValue
        }
    }
}

// MARK: - UI Layout
extension HomeTableViewCell {
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(button)
    }
    
    private func configureLayout() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
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
extension HomeTableViewCell {
    public func set(viewModel: HomeTableViewCellProtocol) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.titleLabel
    }
}
