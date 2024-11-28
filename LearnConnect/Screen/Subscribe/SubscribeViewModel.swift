//
//  SubscribeViewModel.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 26.11.2024.
//

import UIKit

protocol SubscribeViewDataSource {}

protocol SubscribeViewEventSource {}

protocol SubscribeViewProtocol: SubscribeViewDataSource, SubscribeViewEventSource {}

final class SubscribeViewModel: BaseViewModel<SubscribeRouter>, SubscribeViewProtocol {
    
    var subscribeItems: [Data] = []
}

// MARK: - Action
extension SubscribeViewModel {
    
    func didSelectCourse(indexPath: IndexPath) {
        let item = subscribeItems[indexPath.row]
        let selectedTitle = item.title ?? "Unknown Course"
        let imageName = selectedTitle.lowercased()
        let image = UIImage(named: imageName)
        
        router.pushCourseDetailRoute(title: selectedTitle, image: image!)
    }
}
