//
//  FavoritesViewController.swift
//  LearnConnect
//
//  Created by Melih Avcı on 25.11.2024.
//

import UIKit

//final class FavoritesViewController: BaseViewController<FavoritesViewModel> {
//    
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .blue
//    }
//}
//
//// MARK: - UILayout
//extension FavoritesViewController {
//    
//}
//
//// MARK: - Configure Contents And Localize
//extension FavoritesViewController {
//    
//    private func configureContents() {
//        
//    }
//}

import UIKit
import CoreData

final class FavoritesViewController: BaseViewController<FavoritesViewModel> {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "FavoritesTableViewCell")
        return tableView
    }()
    
    private var favoriteItems: [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContents()
        setLocalize()
        loadFavoritesFromCoreData()
    }
}

// MARK: - UILayout
extension FavoritesViewController {
    
    private func addSubviews() {
        view.addSubview(tableView)
        tableView.edgesToSuperview(usingSafeArea: true)
    }
}

// MARK: - Configure Contents And Localize
extension FavoritesViewController {

    private func configureContents() {
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFavorites), name: .favoriteAdded, object: nil)
    }
    
    private func setLocalize() {
        navigationItem.title = FavoritesTexts.navigationTitle
    }
    
    @objc private func reloadFavorites() {
        loadFavoritesFromCoreData()
    }
    
    private func loadFavoritesFromCoreData() {
        if let fetchedFavorites = CoreDataManager.shared.fetchData() {
            favoriteItems = fetchedFavorites
            tableView.reloadData()
        }
    }

}

// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
        let item = favoriteItems[indexPath.row]
        
        if let title = item.title {
            cell.configure(title: title)
        } else {
            cell.configure(title: "Default Title")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let item = favoriteItems[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            
            CoreDataManager.shared.deleteData(id: item.id)
            
            self.favoriteItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }

}



