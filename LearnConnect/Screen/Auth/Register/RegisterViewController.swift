//
//  RegisterViewController.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

import UIKit
import TinyConstraints
import SwiftEntryKit


final class RegisterViewController: BaseViewController<RegisterViewModel> {
    
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
    
    private let usernameTextField = FloatLabelTextField()
    private let emailTextField    = FloatLabelTextField()
    private let passwordTextField = FloatLabelTextField()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kayit Ol", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = .appRed
        button.setTitleColor(.label, for: .normal)
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
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26)
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginButton: UIButton = {
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
extension RegisterViewController {
    
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
        
        bodyStackView.addArrangedSubview(usernameTextField)
        usernameTextField.height(60)
        
        bodyStackView.addArrangedSubview(emailTextField)
        emailTextField.height(60)
        
        bodyStackView.addArrangedSubview(passwordTextField)
        passwordTextField.height(60)
        
        bodyStackView.addArrangedSubview(signUpButton)
        signUpButton.size(.init(width: 60, height: 60))
    }
    
    private func addBottomStackView() {
        view.addSubview(bottomStackView)
        
        bottomStackView.addArrangedSubview(registerLabel)
        bottomStackView.addArrangedSubview(loginButton)
        
        bottomStackView.centerXToSuperview()
        bottomStackView.leadingToSuperview(relation: .equalOrGreater).constant = 20
        bottomStackView.trailingToSuperview(relation: .equalOrLess).constant = -20
        bottomStackView.bottomToSuperview(usingSafeArea: true)
        bottomStackView.topToBottom(of: scrollView).constant = 20
    }
}

// MARK: - Configure Contents  And Localize
extension RegisterViewController {
    
    private func configureContents() {
        
        view.backgroundColor = .appWhite
        
        usernameTextField.leftImage = .icUser
        usernameTextField.autocorrectionType = .no
        usernameTextField.autocapitalizationType = .none
        
        emailTextField.leftImage = .icMail
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.keyboardType = .emailAddress
        
        passwordTextField.leftImage = .icPassword
        passwordTextField.isSecureTextEntry = true
        
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    private func setLocalize() {
        navigationItem.title = RegisterTexts.navigationTitle
        usernameTextField.title = RegisterTexts.usernamePlaceHolder
        emailTextField.title = RegisterTexts.emailPlaceHolder
        passwordTextField.title = RegisterTexts.passwordPlaceHolder
        signUpButton.setTitle(RegisterTexts.signUpButtonText, for: .normal)
        loginButton.setTitle(RegisterTexts.bottomButtonText, for: .normal)
        registerLabel.text = RegisterTexts.bottomLabelText
    }
}

// MARK: - Validation And Request
extension RegisterViewController {
    
    @objc
    func didTapSignUp() {
        guard let username = usernameTextField.text,
              let email    = emailTextField.text,
              let password = passwordTextField.text else {
            showWarningToast(message: RegisterTexts.emptyFields)
            return
        }
        
        let validation = Validation()
        guard validation.isValidEmail(email) else { return }
        guard validation.isValidPassword(password) else { return }
        
        viewModel.sendRegisterRequest(username: username, email: email, password: password)
    }
    
    @objc
    private func didTapSignIn() {
        viewModel.showLoginScreen()
    }
}
