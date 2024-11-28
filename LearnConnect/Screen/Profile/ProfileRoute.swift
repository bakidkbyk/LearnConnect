//
//  ProfileRoute.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 26.11.2024.
//

import UIKit

protocol ProfileRoute {
    func pushProfile()
}

extension ProfileRoute where Self: RouterProtocol {
    
    func pushProfile() {
        let router = ProfileRouter()
        let viewModel = ProfileViewModel(router: router)
        let viewController = ProfileViewController(viewModel: viewModel)

        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        viewController.hidesBottomBarWhenPushed = true

        open(viewController, transition: transition)
    }
}
