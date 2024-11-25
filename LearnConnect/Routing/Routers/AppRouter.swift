//
//  AppRouter.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

import UIKit

protocol AppRouterRoutes: WalkthroughRoute {
    func startApp()
}

final class AppRouter: Router, AppRouterRoutes {

    static let shared = AppRouter()

    func startApp() {
        placeOnWindowWalkthrough()
    }
    
}


