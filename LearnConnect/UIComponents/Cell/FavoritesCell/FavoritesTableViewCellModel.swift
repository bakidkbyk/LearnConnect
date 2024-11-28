//
//  FavoritesTableViewCellModel.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 26.11.2024.
//

import UIKit

public protocol FavoritesTableViewCellModelDataSource: AnyObject {
    var titleLabel: String { get }
    var id: Int { get set }
}

public protocol FavoritesTableViewCellModelEventSource: AnyObject { }

public protocol FavoritesTableViewCellModelProtocol: FavoritesTableViewCellModelDataSource, FavoritesTableViewCellModelEventSource { }

public class FavoritesTableViewCellModel: FavoritesTableViewCellModelProtocol {

    public var titleLabel: String
    public var id: Int

    public init(titleLabel: String, id: Int) {
        self.titleLabel = titleLabel
        self.id = id 
    }
}
