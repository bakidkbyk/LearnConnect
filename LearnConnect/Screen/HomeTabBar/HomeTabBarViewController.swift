//
//  HomeTabBarViewController.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 25.11.2024.
//

import UIKit

class HomeTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .appRed

        let homeViewController = createHomeViewController()
        let favoritesViewController = createFavoritesController()
        let subscribeViewController = createSubscribeController()

        viewControllers = [
            homeViewController,
            favoritesViewController,
            subscribeViewController
        ]
    }
    
    private func createHomeViewController() -> UINavigationController {
        let homeRouter = HomeViewRouter()
        let homeViewModel = HomeViewModel(router: homeRouter)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        let navigationController = MainNavigationController(rootViewController: homeViewController)
        navigationController.tabBarItem.image = UIImage.icHome
        homeRouter.viewController = homeViewController
        return navigationController
    }
    
    private func createFavoritesController() -> UINavigationController {
        let favoritesRouter = FavoritesRouter()
        let favoritesViewModel = FavoritesViewModel(router: favoritesRouter)
        let favoritesViewController = FavoritesViewController(viewModel: favoritesViewModel)
        let navigationController = MainNavigationController(rootViewController: favoritesViewController)
        navigationController.tabBarItem.image = UIImage.icHeart
        favoritesRouter.viewController = favoritesViewController
        return navigationController
    }
    
    private func createSubscribeController() -> UINavigationController {
        let subscribeRouter = SubscribeRouter()
        let subscribeViewModel = SubscribeViewModel(router: subscribeRouter)
        let subscribeViewController = SubscribeViewController(viewModel: subscribeViewModel)
        let navigationController = MainNavigationController(rootViewController: subscribeViewController)
        navigationController.tabBarItem.image = UIImage.init(systemName: "bell")
        subscribeRouter.viewController = subscribeViewController
        return navigationController
    }
}
