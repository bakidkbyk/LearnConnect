//
//  ProfileViewController.swift
//  LearnConnect
//
//  Created by Melih Avcı on 26.11.2024.
//

import UIKit

final class ProfileViewController: BaseViewController<ProfileViewModel> {
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    
    private let themeSegmentedControl: UISegmentedControl = {
        let items = ["Light", "Dark"]
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "themeMode")
        segmentControl.addTarget(self, action: #selector(themeChanged(_:)), for: .valueChanged)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContents()
        setLocalize()
        fetchUserData()
    }
}

// MARK: - Theme Handling
extension ProfileViewController {
    
    @objc private func themeChanged(_ sender: UISegmentedControl) {
        let selectedTheme = sender.selectedSegmentIndex
        UserDefaults.standard.set(selectedTheme, forKey: "themeMode")
        
        let style: UIUserInterfaceStyle = selectedTheme == 0 ? .light : .dark
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.updateTheme(to: style)
        }
    }
}

// MARK: - UILayout
extension ProfileViewController {
    
    private func addSubviews() {
 
        view.addSubview(contentStackView)
        contentStackView.centerXToSuperview()
        contentStackView.centerYToSuperview()
        
        contentStackView.addArrangedSubview(usernameLabel)
        contentStackView.addArrangedSubview(emailLabel)
        contentStackView.addArrangedSubview(themeSegmentedControl)
    }
}

// MARK: - Configure Contents And Localize
extension ProfileViewController {
    
    private func configureContents() {
        view.backgroundColor = .white

    }
    
    private func setLocalize() {
        navigationItem.title = ProfileTexts.navigationTitle
    }

}

// MARK: - Fetch User Data
extension ProfileViewController {
    
    private func fetchUserData() {
        AuthService.shared.fetchUser { [weak self] user, error in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                return
            }
            
            if let user = user {
                DispatchQueue.main.async {
                    self?.usernameLabel.text = "Kullanıcı Adı: \(user.username)"
                    self?.emailLabel.text = "Email: \(user.email)"
                }
            }
        }
    }
}

