//
//  HomeTabBarRoute.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 25.11.2024.
//

protocol HomeTabBarRoute {
    func placeOnWindowTabBar()
}

extension HomeTabBarRoute where Self: RouterProtocol {
    
    func placeOnWindowTabBar() {
        let homeTabBarController = HomeTabBarViewController()
        let transition = PlaceOnWindowTransition()
        
        open(homeTabBarController, transition: transition)
    }
}
