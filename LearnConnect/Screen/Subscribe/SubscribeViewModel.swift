//
//  SubscribeViewModel.swift
//  LearnConnect
//
//  Created by Melih Avcı on 26.11.2024.
//

import Foundation

protocol SubscribeViewDataSource {}

protocol SubscribeViewEventSource {}

protocol SubscribeViewProtocol: SubscribeViewDataSource, SubscribeViewEventSource {}

final class SubscribeViewModel: BaseViewModel<SubscribeRouter>, SubscribeViewProtocol {
    
    var subscribeItems: [Data] = []

}
