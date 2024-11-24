//
//  AppDelegate.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let bounds = UIScreen.main.bounds
        self.window = UIWindow(frame: bounds)
        AppRouter.shared.startApp()
        self.window?.makeKeyAndVisible()
        return true
    }
}


