//
//  SubscribeViewController.swift
//  LearnConnect
//
//  Created by Melih Avcı on 26.11.2024.
//
//
import UIKit

final class SubscribeViewController: BaseViewController<SubscribeViewModel> {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SubscribeTableViewCell.self, forCellReuseIdentifier: "SubscribeTableViewCell")
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContents()
        setLocalize()
        loadSubscriptionsFromCoreData()
    }
}

// MARK: - UILayout
extension SubscribeViewController {
    
    private func addSubviews() {
        view.addSubview(tableView)
        tableView.edgesToSuperview(usingSafeArea: true)
    }
}

// MARK: - Configure Contents And Localize
extension SubscribeViewController {

    private func configureContents() {
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSubscriptions), name: .subscribeAdded, object: nil)
    }
    
    private func setLocalize() {
        navigationItem.title = SubscribeTexts.navigationTitle
    }
    
    @objc private func reloadSubscriptions() {
        loadSubscriptionsFromCoreData()
    }
    
    private func loadSubscriptionsFromCoreData() {
        let predicate = NSPredicate(format: "type == %@", "subscribe") 
        if let fetchedSubscriptions = CoreDataManager.shared.fetchData(predicate: predicate) {
            viewModel.subscribeItems = fetchedSubscriptions
            tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension SubscribeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCourse(indexPath: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension SubscribeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.subscribeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscribeTableViewCell", for: indexPath) as! SubscribeTableViewCell
        let item = viewModel.subscribeItems[indexPath.row]
        
        if let title = item.title {
            cell.configure(title: title)
        } else {
            cell.configure(title: "Default Title")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = viewModel.subscribeItems[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            
            CoreDataManager.shared.deleteData(id: item.id)
            
            self.viewModel.subscribeItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
