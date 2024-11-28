//
//  ReusableView.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 25.11.2024.
//

import UIKit

public protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
