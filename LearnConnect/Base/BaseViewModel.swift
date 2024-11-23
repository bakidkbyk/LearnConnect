//
//  BaseViewModel.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

import UIKit

protocol BaseViewModelDataSource: AnyObject { }

protocol BaseViewModelEventSource: AnyObject {}

protocol BaseViewModeProtocol: BaseViewModelDataSource, BaseViewModelEventSource {}

class BaseViewModel<R: Router>: BaseViewModeProtocol {
    let router: R
    
    init(router: R) {
        self.router = router
    }
}
