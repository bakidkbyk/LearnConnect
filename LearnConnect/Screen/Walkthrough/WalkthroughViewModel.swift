//
//  WalkthroughViewModel.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 25.11.2024.
//

import UIKit

protocol WalkthroughViewDataSource {
    func numberOfItemsAt() -> Int
    func cellItemAt(indexPath: IndexPath) -> WalkthroughCellProtocol
}

protocol WalkthroughViewEventSource {}

protocol WalkthroughViewProtocol: WalkthroughViewDataSource, WalkthroughViewEventSource {
    func didFinishWalkthrough()
}

final class WalkthroughViewModel: BaseViewModel<WalkthroughRouter>, WalkthroughViewProtocol {
    
    func numberOfItemsAt() -> Int {
        cellItems.count
    }
    
    func cellItemAt(indexPath: IndexPath) -> WalkthroughCellProtocol {
        return cellItems[indexPath.row]
    }
    private var cellItems: [WalkthroughCellProtocol] = [WalkthroughCellModel(image: .imgWalkthroughCertificate,
                                                                             titleLabel: WalkthroughTexts.firstImageTitle,
                                                                             descriptionLabel: WalkthroughTexts.firstImageSubtitle),
                                                        WalkthroughCellModel(image: .imgWalkthroughEducation,
                                                                             titleLabel: WalkthroughTexts.secondImageTitle,
                                                                             descriptionLabel: WalkthroughTexts.secondImageSubtitle),
                                                        WalkthroughCellModel(image: .imgWalkthroughLesson, titleLabel: WalkthroughTexts.thirdImageTitle,
                                                                             descriptionLabel: WalkthroughTexts.thirdImagesubtitle)]
    
}

// MARK: - Actions
extension WalkthroughViewModel {
    
    func didFinishWalkthrough() {
        router.presentRegister()
    }
}
