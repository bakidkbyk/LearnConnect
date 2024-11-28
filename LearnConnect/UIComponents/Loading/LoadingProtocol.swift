//
//  LoadingProtocol.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 25.11.2024.
//

import UIKit

public protocol LoadingProtocol {
    func presentLoading()
    func dismissLoading()
}

public extension LoadingProtocol where Self: UIViewController {
    
    func presentLoading() {
        let window = UIApplication.shared.windows.first
        window?.startBlockingActivityIndicator()
    }
    
    func dismissLoading() {
        let window = UIApplication.shared.windows.first
        window?.stopBlockingActivityIndicator()
    }
    
}
