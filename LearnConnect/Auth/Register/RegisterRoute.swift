//
//  RegisterRoute.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

import UIKit

protocol RegisterRoute {
    func presentRegister()
}

extension RegisterRoute where Self: RouterProtocol {
    
    func presentRegister() {
        let router = RegisterRouter()
        let viewModel = RegisterViewModel(router: router)
        let viewController = RegisterViewController(viewModel: viewModel)
        let navigationContoller = UINavigationController(rootViewController: viewController)

        
        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
