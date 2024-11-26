//
//  FavoritesViewModel.swift
//  LearnConnect
//
//  Created by Melih Avcı on 25.11.2024.
//

import Foundation

protocol FavoritesViewDataSource {}

protocol FavoritesViewEventSource {}

protocol FavoritesViewProtocol: FavoritesViewDataSource, FavoritesViewEventSource {}

final class FavoritesViewModel: BaseViewModel<FavoritesRouter>, FavoritesViewProtocol {
    
    var favoriteItems: [Data] = []

}
