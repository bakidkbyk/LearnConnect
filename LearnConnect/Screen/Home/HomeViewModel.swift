//
//  HomeViewModel.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

import CoreData

protocol HomeViewDataSource {}

protocol HomeViewEventSource {}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {}

final class HomeViewModel: BaseViewModel<HomeViewRouter>, HomeViewProtocol {
    
    func addToFavorites(title: String) {
        let id = Int64(Date().timeIntervalSince1970)
        let predicate = NSPredicate(format: "id == %d", id)
        
        if let existingData = CoreDataManager.shared.fetchData(predicate: predicate), existingData.isEmpty {
            // Veriyi ekle
            CoreDataManager.shared.createData(id: id, title: title)
            
            // Favoriye eklenen öğe için bildirim gönder
            NotificationCenter.default.post(name: .favoriteAdded, object: nil)
        } else {
            print("Aynı ID'ye sahip veri zaten mevcut.")
        }
    }
}
