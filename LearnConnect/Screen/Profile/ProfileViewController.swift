//
//  ProfileViewController.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 26.11.2024.
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
        label.textColor = .label
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .label
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
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Çıkış Yap", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContents()
        setLocalize()
        fetchUserData()
        addThemeChangeObserver()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBarForTheme()
    }

    func configureNavigationBarForTheme() {
        let themeMode = UserDefaults.standard.integer(forKey: "themeMode")
        
        if themeMode == 0 {
            navigationController?.navigationBar.tintColor = .black
        } else {
            navigationController?.navigationBar.tintColor = .white
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .themeChangedNotification, object: nil)
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

        NotificationCenter.default.post(name: .themeChangedNotification, object: nil, userInfo: ["style": style])
        
        configureNavigationBarForTheme()
    }
    
    @objc private func themeChangedNotification(notification: Notification) {
        if let style = notification.userInfo?["style"] as? UIUserInterfaceStyle {
            view.window?.overrideUserInterfaceStyle = style
        }
    }

    private func addThemeChangeObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(themeChangedNotification),
                                               name: .themeChangedNotification,
                                               object: nil)
    }
}

// MARK: - UI Layout
extension ProfileViewController {

    private func addSubviews() {
        view.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        contentStackView.addArrangedSubview(usernameLabel)
        contentStackView.addArrangedSubview(emailLabel)
        contentStackView.addArrangedSubview(themeSegmentedControl)
        
        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 10)
        ])
    }
}

// MARK: - Configure Contents And Localize
extension ProfileViewController {

    private func configureContents() {
        view.backgroundColor = .systemBackground
        
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }

    @objc
    private func logoutButtonTapped() {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        AppRouter.shared.startApp()
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

