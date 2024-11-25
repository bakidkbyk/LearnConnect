//
//  HomeViewRoute.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

protocol HomeViewRoute {
    func presentHome()
}

extension HomeViewRoute where Self: RouterProtocol {
    
    func presentHome() {
        let router = HomeViewRouter()
        let viewModel = HomeViewModel(router: router)
        let viewController = HomeViewController(viewModel: viewModel)
        
        let transition = ModalTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
