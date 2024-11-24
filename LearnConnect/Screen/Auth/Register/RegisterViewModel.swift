//
//  RegisterViewModel.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

import Foundation

protocol RegisterViewDataSource {}

protocol RegisterViewEventSource {}

protocol RegisterViewProtocol: RegisterViewDataSource, RegisterViewEventSource {}

final class RegisterViewModel: BaseViewModel<RegisterRouter>, RegisterViewProtocol  {
    
    func SigUpSuccess() {
        router.presentLogin()
    }
}
