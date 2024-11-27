//
//  SubscribeRoute.swift
//  LearnConnect
//
//  Created by Melih Avcı on 27.11.2024.
//

import UIKit

protocol SubscribeRoute {
    func pushSubscribe()
}

extension SubscribeRoute where Self: RouterProtocol {
    
    func pushSubscribe() {
        let router = SubscribeRouter()
        let viewModel = SubscribeViewModel(router: router)
        let viewController = SubscribeViewController(viewModel: viewModel)
        let navigationContoller = UINavigationController(rootViewController: viewController)

        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(navigationContoller, transition: transition)
    }
}
