//
//  SubscribeTableViewCellModel.swift
//  LearnConnect
//
//  Created by Melih Avcı on 26.11.2024.
//

import UIKit

public protocol SubscribeTableViewCellModelDataSource: AnyObject {
    var titleLabel: String { get }
    var id: Int { get set }
}

public protocol SubscribeTableViewCellModelEventSource: AnyObject { }

public protocol SubscribeTableViewCellModelProtocol: SubscribeTableViewCellModelDataSource, SubscribeTableViewCellModelEventSource { }

public class SubscribeTableViewCellModel: SubscribeTableViewCellModelProtocol {

    public var titleLabel: String
    public var id: Int

    public init(titleLabel: String, id: Int) {
        self.titleLabel = titleLabel
        self.id = id
    }
}

