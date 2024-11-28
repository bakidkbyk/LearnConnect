//
//  LoginViewModel.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 24.11.2024.
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
        router.placeOnWindowTabBar()
    }
    
    func newUserTapped() {
        router.close()
    }
    
}
// MARK: - Firebase Url
extension LoginViewModel {
    
    func sendLoginRequest(email: String, password: String) {
        showLoading?()
        
        let loginRequest = LoginUserRequest(email: email, password: password)
        
        AuthService.shared.signIn(with: loginRequest) { [weak self] error, wasLogin in
            guard let self = self else { return }
            self.hideLoading?()
            self.showWarningToast?("Başarılı")

            
            if let error = error {
                self.showWarningToast?(error.localizedDescription)
                return
            }
            
            if wasLogin {
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                loginSuccess()
            } else {
                self.showWarningToast?("Bilinmeyen bir hata oluştu. Lütfen tekrar deneyin.")
            }
        }
    }
}
