//
//  WalkthroughRoute.swift
//  LearnConnect
//
//  Created by Melih Avcı on 25.11.2024.
//

import UIKit

protocol WalkthroughRoute {
    func placeOnWindowWalkthrough()
}

extension WalkthroughRoute where Self: RouterProtocol {
    
    func placeOnWindowWalkthrough() {
        let router = WalkthroughRouter()
        let viewModel = WalkthroughViewModel(router: router)
        let viewController = WalkthroughViewController(viewModel: viewModel)
        let navigationContoller = UINavigationController(rootViewController: viewController)
        
        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(navigationContoller, transition: transition)
    }
}
