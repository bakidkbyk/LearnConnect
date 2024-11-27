//
//  ProfileViewModel.swift
//  LearnConnect
//
//  Created by Melih Avcı on 26.11.2024.
//

import Foundation

protocol ProfileViewModelDataSource {}

protocol ProfileViewModelEventSource {}

protocol ProfileViewModelProtocol: ProfileViewModelDataSource, ProfileViewModelEventSource {
}

final class ProfileViewModel: BaseViewModel<ProfileRouter>, ProfileViewModelProtocol {
    

}

// MARK: - Network
extension ProfileViewModel {
    

}
