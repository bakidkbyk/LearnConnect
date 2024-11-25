//
//  LoginViewController.swift
//  LearnConnect
//
//  Created by Melih Avcı on 24.11.2024.
//

import UIKit
import TinyConstraints

final class LoginViewController: BaseViewController<LoginViewModel> {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 50
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let emailTextField    = FloatLabelTextField()
    private let passwordTextField = FloatLabelTextField()
    
    private let actionLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Giris Yap", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        setLocalize()
    }
}

// MARK: - UILayout
extension LoginViewController {
    
    private func addSubViews() {
        addScrollView()
        addContentStackView()
        addTextFieldStackView()
        addBottomStackView()
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        
        scrollView.addSubview(contentView)
        contentView.edgesToSuperview()
        contentView.widthToSuperview()
        
        contentView.addSubview(contentStackView)
        contentStackView.edgesToSuperview(insets: .left(15) + .right(15))
    }
    
    private func addContentStackView() {
        contentStackView.addArrangedSubview(titleLabel)
        
        contentStackView.addArrangedSubview(bodyStackView)
    }
    
    private func addTextFieldStackView() {
        
        bodyStackView.addArrangedSubview(emailTextField)
        emailTextField.height(60)
        
        bodyStackView.addArrangedSubview(passwordTextField)
        passwordTextField.height(60)
        
        bodyStackView.addArrangedSubview(actionLoginButton)
        actionLoginButton.height(60)
    }
    
    private func addBottomStackView() {
        view.addSubview(bottomStackView)
        
        bottomStackView.addArrangedSubview(loginLabel)
        bottomStackView.addArrangedSubview(registerButton)
        
        bottomStackView.centerXToSuperview()
        bottomStackView.leadingToSuperview(relation: .equalOrGreater).constant = 20
        bottomStackView.trailingToSuperview(relation: .equalOrLess).constant = -20
        bottomStackView.bottomToSuperview(usingSafeArea: true)
        bottomStackView.topToBottom(of: scrollView).constant = 20
    }
}

// MARK: - Configure Contents And Localize
extension LoginViewController {
    
    private func configureContents() {
        
        view.backgroundColor = .white
        
        emailTextField.leftImage = .icMail
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.keyboardType = .emailAddress
        
        passwordTextField.leftImage = .icPassword
        passwordTextField.isSecureTextEntry = true
        
        actionLoginButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
    }
    
    private func setLocalize() {
        titleLabel.text = LoginTexts.title
        emailTextField.title = LoginTexts.emailPlaceHolder
        passwordTextField.title = LoginTexts.passwordPlaceHolder
        actionLoginButton.setTitle(LoginTexts.loginButtonText, for: .normal)
        loginLabel.text = LoginTexts.bottomLabelText
        registerButton.setTitle(LoginTexts.bottomButtonText, for: .normal)
    
    }
}

// MARK: - Validation and Request
extension LoginViewController {
    
    @objc
    func didTapSignIn() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            self.showWarningToast(message: LoginTexts.emptyFields)
            return
        }
        
        let validation = Validation()
        guard validation.isValidPassword(password) else { return }
        
        viewModel.sendLoginRequest(email: email, password: password)

    }
    
    @objc private func didTapNewUser() {
        viewModel.newUserTapped()
    }
}

