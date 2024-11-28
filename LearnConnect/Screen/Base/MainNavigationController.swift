//
//  MainNavigationController.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 25.11.2024.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
    }
    
    func configureContents() {
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Nunito-ExtraBold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold),
            .foregroundColor: UIColor.white
        ]
        
        navigationBar.isTranslucent = true
        navigationBar.tintColor = .appWhite
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.shadowColor = .clear
            appearance.backgroundColor = .appRed
            appearance.titleTextAttributes = textAttributes
            
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance = appearance
        } else {
            navigationBar.barTintColor = .appRed
            navigationBar.titleTextAttributes = textAttributes
            navigationBar.shadowImage = nil
            navigationBar.backgroundColor = .appRed
        }
    }
}
