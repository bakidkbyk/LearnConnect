//
//  CoreDataManager.swift
//  LearnConnect
//
//  Created by Melih Avcı on 26.11.2024.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() { }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LearnConnect")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
    
    func fetchData(predicate: NSPredicate? = nil) -> [Data]? {
        let request: NSFetchRequest<Data> = Data.fetchRequest()
        request.predicate = predicate
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch data: \(error)")
            return nil
        }
    }
    
    func createData(id: Int64, title: String, type: String) {
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Data", into: context) as! Data
        newItem.id = id
        newItem.title = title
        newItem.type = type
        saveContext()
    }
    
    func deleteData(id: Int64) {
        let fetchRequest: NSFetchRequest<Data> = Data.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let objectToDelete = results.first {
                context.delete(objectToDelete)
                try context.save()
                print("Veri başarıyla silindi.")
            }
        } catch {
            print("Veri silinirken hata oluştu: \(error)")
        }
    }
    
    func fetchItemsByType(type: String) -> [Data]? {
        let predicate = NSPredicate(format: "type == %@", type)
        return fetchData(predicate: predicate)
    }
}

