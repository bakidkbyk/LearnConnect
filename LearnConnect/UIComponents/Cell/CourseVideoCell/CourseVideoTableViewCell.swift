//
//  CourseVideoTableViewCell.swift
//  LearnConnect
//
//  Created by Melih Avcı on 27.11.2024.
//

import UIKit

public class CourseVideoTableViewCell: UITableViewCell {
    
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
    
    private let videoNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
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

    
    var viewModel: CourseVideoTableViewCellModelProtocol?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
    }
}

// MARK: - UILayout
extension CourseVideoTableViewCell {
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.edgesToSuperview(insets: .horizontal(16))

        containerView.addSubview(stackView)
        stackView.edgesToSuperview(insets: .vertical(8))

        stackView.addArrangedSubview(videoNameLabel)
        stackView.addArrangedSubview(button)

        button.size(CGSize(width: 10, height: 10))
    }
}

// MARK: - Set ViewModel
extension CourseVideoTableViewCell {
    
    public func set(viewModel: CourseVideoTableViewCellModelProtocol) {
        self.viewModel = viewModel
        self.videoNameLabel.text = viewModel.videoName
    }
}
