//
//  ActivityIndicatorProtocol.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 25.11.2024.
//

import UIKit

public protocol ActivityIndicatorProtocol {
    func showActivityIndicator()
    func hideActivityIndicator()
}

public extension ActivityIndicatorProtocol where Self: UIViewController {
    func showActivityIndicator() {
        let indicator = ActivityIndicatorView(frame: .infinite)
        indicator.startAnimating()
        view.addSubview(indicator)
        indicator.centerInSuperview()
        view.bringSubviewToFront(indicator)
    }
    
    func hideActivityIndicator() {
        view.subviews.filter({ $0 is ActivityIndicatorView }).forEach({ $0.removeFromSuperview() })
    }
}
