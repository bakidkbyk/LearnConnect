//
//  AppDelegate.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseMessaging
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LearnConnect")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let bounds = UIScreen.main.bounds
        self.window = UIWindow(frame: bounds)
        AppRouter.shared.startApp()
        
        let savedThemeIndex = UserDefaults.standard.integer(forKey: "themeMode")
        let style: UIUserInterfaceStyle = savedThemeIndex == 0 ? .light : .dark
        updateTheme(to: style)
        
        self.window?.makeKeyAndVisible()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
            
            guard success else { return }
            print("Success is APNS registry")
        }
        application.registerForRemoteNotifications()
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else { return}
            print("Token: \(token)")
        }
    }

    
    func updateTheme(to style: UIUserInterfaceStyle) {
        if let window = self.window {
            window.overrideUserInterfaceStyle = style
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveContext()
    }
}
