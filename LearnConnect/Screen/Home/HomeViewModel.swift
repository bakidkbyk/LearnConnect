//
//  HomeViewModel.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

import CoreData
import UIKit

protocol HomeViewDataSource {}

protocol HomeViewEventSource {}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {
    func profileIconTapped()
}

final class HomeViewModel: BaseViewModel<HomeViewRouter>, HomeViewProtocol {

    var titles = ["Matematik", "Fizik", "Kimya", "Tarih", "Biyoloji"]
    var filteredTitles = [String]()
    var searchItems = [String]()
    var courseName: String = ""
    
    func addToFavorites(title: String) {
        let id = Int64(Date().timeIntervalSince1970)
        let predicate = NSPredicate(format: "id == %d", id)
        
        if let existingData = CoreDataManager.shared.fetchData(predicate: predicate), existingData.isEmpty {
            CoreDataManager.shared.createData(id: id, title: title, type: "favorite")
            
            NotificationCenter.default.post(name: .favoriteAdded, object: nil)
        } else {
            print("Aynı ID'ye sahip veri zaten mevcut.")
        }
    }
    
    func addToSubscribe(title: String) {
        let id = Int64(Date().timeIntervalSince1970)
        let predicate = NSPredicate(format: "id == %d", id)
        
        if let existingData = CoreDataManager.shared.fetchData(predicate: predicate), existingData.isEmpty {
            CoreDataManager.shared.createData(id: id, title: title, type: "subscribe")
            
            NotificationCenter.default.post(name: .subscribeAdded, object: nil)
        } else {
            print("Aynı ID'ye sahip veri zaten mevcut.")
        }
    }
 
    func profileIconTapped() {
        router.pushProfile()
    }
}
