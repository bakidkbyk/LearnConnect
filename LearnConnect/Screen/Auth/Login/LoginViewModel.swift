//
//  LoginViewModel.swift
//  LearnConnect
//
//  Created by Melih Avcı on 24.11.2024.
//

import UIKit

protocol LoginViewDataSource {}

protocol LoginViewEventSource {}

protocol LoginViewProtocol: RegisterViewDataSource, LoginViewEventSource {
    func newUserTapped()
    func loginSuccess()
    
    func sendLoginRequest(email: String, password: String)
}

final class LoginViewModel: BaseViewModel<LoginRouter>, LoginViewProtocol  {

    func loginSuccess() {
        print("Giriş başarılı")
    }
    
    
    func newUserTapped() {
        router.close()
    }
    
}
// MARK: - Firebase Url
extension LoginViewModel {
//    func sendLoginRequest(loginRequest: LoginRequest) {
//        showLoading?()
//        
//        AuthService.shared.signIn(with: loginRequest) { [weak self] error, wasRegistered in
//            guard let self = self else { return }
//            self.hideLoading?()
//            
//            if let error = error {
//                self.showWarningToast?(error.localizedDescription)
//                return
//            }
//            
//            if wasRegistered {
//                self.viewModel.loginSuccess()
//            } else {
//                self.showWarningToast?("Bilinmeyen bir hata oluştu. Lütfen tekrar deneyin.")
//            }
//        }
//    }
    
    func sendLoginRequest(email: String, password: String) {
        showLoading?()
        
        let loginRequest = LoginUserRequest(email: email, password: password)
        
        AuthService.shared.signIn(with: loginRequest) { [weak self] error, wasLogin in
            guard let self = self else { return }
            self.hideLoading?()
            
            if let error = error {
                self.showWarningToast?(error.localizedDescription)
                return
            }
            
            if wasLogin {
                self.showWarningToast?("Giriş Başarılı")
            } else {
                self.showWarningToast?("Bilinmeyen bir hata oluştu. Lütfen tekrar deneyin.")
            }
        }
    }
}
