//
//  HomeViewController.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

import UIKit

final class HomeViewController: BaseViewController<HomeViewModel> {

    private let searchBar = UISearchBar()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var searchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContents()
        setLocalize()
    }
    
    // MARK: - Add subviews and configure contents
    private func addSubviews() {
        view.addSubview(tableView)
        tableView.edgesToSuperview()
    }

    private func configureContents() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        viewModel.filteredTitles = viewModel.titles
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }

    private func setLocalize() {
        searchBar.placeholder = HomeTexts.searchBarText
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        searchTimer = nil
        
        if searchText.count >= 2 {
            searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                guard let self = self else { return }
                
                self.viewModel.filteredTitles = self.viewModel.titles.filter {
                    $0.lowercased().contains(searchText.lowercased())
                }
                self.tableView.reloadData()
            })
        } else if searchText.isEmpty {
            viewModel.filteredTitles = viewModel.titles
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.filteredTitles = viewModel.titles
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        let title = viewModel.filteredTitles[indexPath.row]
        cell.configure(title: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Tapped on: \(viewModel.filteredTitles[indexPath.row])")
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         
         let favoriteAction = UIContextualAction(style: .normal, title: "Favori Ekle") { [weak self] (action, view, completionHandler) in
             self?.addFavorite(at: indexPath)
             completionHandler(true)
         }
         favoriteAction.backgroundColor = .systemRed
         favoriteAction.image = UIImage(systemName: "heart")
         
         let subscribeAction = UIContextualAction(style: .normal, title: "Abone Ol") { [weak self] (action, view, completionHandler) in
             self?.subscribeToItem(at: indexPath)
             completionHandler(true)
         }
         subscribeAction.backgroundColor = .systemBlue
         subscribeAction.image = UIImage(systemName: "bell")
         
         let configuration = UISwipeActionsConfiguration(actions: [favoriteAction, subscribeAction])
         return configuration
     }
    
    private func addFavorite(at indexPath: IndexPath) {
        let item = viewModel.filteredTitles[indexPath.row]
        viewModel.addToFavorites(title: item)
        showWarningToast(message: "Favori eklendi!")
        tableView.reloadData()
    }
    
    private func subscribeToItem(at indexPath: IndexPath) {
        let item = viewModel.filteredTitles[indexPath.row]
        viewModel.addToSubscribe(title: item)
        showWarningToast(message: "Abone Olundu!")
        tableView.reloadData()
    }

}
