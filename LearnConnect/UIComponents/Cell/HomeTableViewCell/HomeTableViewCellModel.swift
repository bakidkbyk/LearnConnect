//
//  HomeTableViewCellModel.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 25.11.2024.
//

import UIKit

public protocol HomeTableViewCellDataSource: AnyObject {
    var titleLabel: String { get }
}

public protocol HomeTableViewCellEventSource: AnyObject { }

public protocol HomeTableViewCellProtocol: HomeTableViewCellDataSource, HomeTableViewCellEventSource { }

public class HomeTableViewCellModel: HomeTableViewCellProtocol {
    
    public var titleLabel: String
    
    public init(titleLabel: String) {
        self.titleLabel = titleLabel
    }
}
