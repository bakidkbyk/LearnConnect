//
//  LoginRoute.swift
//  LearnConnect
//
//  Created by Melih Avcı on 24.11.2024.
//

import UIKit

protocol LoginRoute {
    func presentLogin()
}

extension LoginRoute where Self: RouterProtocol {
    
    func presentLogin() {
        let router = LoginRouter()
        let viewModel = LoginViewModel(router: router)
        let viewController = LoginViewController(viewModel: viewModel)
        let navigationController = MainNavigationController(rootViewController: viewController)
        
        let transition = ModalTransition(isAnimated: true, modalTransitionStyle: .coverVertical, modalPresentationStyle: .fullScreen)
        router.viewController = viewController
        router.openTransition = transition
    
        open(navigationController, transition: transition)
    }
}

