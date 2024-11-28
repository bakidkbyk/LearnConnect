//
//  AppRouter.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

import UIKit

protocol AppRouterRoutes: WalkthroughRoute, HomeTabBarRoute, LoginRoute {
    func startApp()
}

final class AppRouter: Router, AppRouterRoutes {

    static let shared = AppRouter()

    func startApp() {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")

        if isUserLoggedIn {
            placeOnWindowTabBar()
        } else {
            placeOnWindowWalkthrough()
        }
    }
}
