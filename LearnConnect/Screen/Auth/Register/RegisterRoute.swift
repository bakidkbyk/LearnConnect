//
//  RegisterRoute.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

import UIKit

protocol RegisterRoute {
    func pushRegister()
}

extension RegisterRoute where Self: RouterProtocol {
    
    func pushRegister() {
        let router = RegisterRouter()
        let viewModel = RegisterViewModel(router: router)
        let viewController = RegisterViewController(viewModel: viewModel)
        let navigationController = MainNavigationController(rootViewController: viewController)
        
        let transition = ModalTransition(isAnimated: true, modalTransitionStyle: .coverVertical, modalPresentationStyle: .fullScreen)
        router.viewController = viewController
        router.openTransition = transition
        
        open(navigationController, transition: transition)
    }
}
