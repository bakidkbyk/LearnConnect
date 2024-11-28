//
//  RegisterViewModel.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

import UIKit

protocol RegisterViewDataSource {}

protocol RegisterViewEventSource {}

protocol RegisterViewProtocol: RegisterViewDataSource, RegisterViewEventSource {
    
    func sendRegisterRequest(username: String, email: String, password: String)
}

final class RegisterViewModel: BaseViewModel<RegisterRouter>, RegisterViewProtocol  {
    
    func showLoginScreen() {
        router.pushLogin()
    }
}

// MARK: - Network
extension RegisterViewModel {
    func sendRegisterRequest(username: String, email: String, password: String) {
        showLoading?()
        
        let registerUserRequest = RegiserUserRequest(username: username, email: email, password: password)
        
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else { return }
            self.hideLoading?()
            
            if let error = error {
                self.showWarningToast?(error.localizedDescription)
                return
            }
            
            if wasRegistered {
                self.showWarningToast?("Kayıt Başarılı")
                self.showLoginScreen()
            } else {
                self.showWarningToast?("An unknown error occurred. Please try again.")
            }
        }
    }
}
