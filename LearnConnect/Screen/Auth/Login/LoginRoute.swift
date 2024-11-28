//
//  LoginRoute.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 24.11.2024.
//

import UIKit

protocol LoginRoute {
    func pushLogin()
}

extension LoginRoute where Self: RouterProtocol {
    
    func pushLogin() {
        let router = LoginRouter()
        let viewModel = LoginViewModel(router: router)
        let viewController = LoginViewController(viewModel: viewModel)

        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
    
        open(viewController, transition: transition)
    }
}
