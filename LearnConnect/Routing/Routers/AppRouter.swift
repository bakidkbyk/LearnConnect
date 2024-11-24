//
//  AppRouter.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

import UIKit

final class AppRouter: Router, AppRouter.Routes {
    
    typealias Routes = RegisterRoute
    static let shared = AppRouter()
    
    func startApp() {
        presentRegister()
    }
}
