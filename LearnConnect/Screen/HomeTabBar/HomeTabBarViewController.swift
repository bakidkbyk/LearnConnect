//
//  HomeTabBarViewController.swift
//  LearnConnect
//
//  Created by Melih Avcı on 25.11.2024.
//

import UIKit

class HomeTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .appRed

        let homeViewController = createHomeViewController()
        let favoritesViewController = createFavoritesController()

        viewControllers = [
            homeViewController,
            favoritesViewController
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
}
