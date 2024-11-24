//
//  LoginViewModel.swift
//  LearnConnect
//
//  Created by Melih Avcı on 24.11.2024.
//

import Foundation

protocol LoginViewDataSource {}

protocol LoginViewEventSource {}

protocol LoginViewProtocol: RegisterViewDataSource, LoginViewEventSource {}

final class LoginViewModel: BaseViewModel<LoginRouter>, LoginViewProtocol  {
    
    func SigUpSuccess() {
    
    }
}
