//
//  HomeViewRoute.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

import UIKit

protocol HomeViewRoute {
    func placeOnWindowHome()
}

extension HomeViewRoute where Self: RouterProtocol {
    
    func placeOnWindowHome() {
        let router = HomeViewRouter()
        let viewModel = HomeViewModel(router: router)
        let viewController = HomeViewController(viewModel: viewModel)
        let navigationContoller = UINavigationController(rootViewController: viewController)

        
        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(navigationContoller, transition: transition)
    }
}
