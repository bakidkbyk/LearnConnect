//
//  CourseDetailViewModel.swift
//  LearnConnect
//
//  Created by Melih Avcı on 27.11.2024.
//

import UIKit

protocol CourseDetailViewModelDataSource {}

protocol CourseDetailViewModelEventSource {}

protocol CourseDetailViewModelProtocol: CourseDetailViewModelDataSource, CourseDetailViewModelEventSource {}

final class CourseDetailViewModel: BaseViewModel<CourseDetailRouter>, CourseDetailViewModelProtocol {
    
    var title: String
    var image: UIImage

    
    init(title: String, image: UIImage, router: CourseDetailRouter) {
        self.title = title
        self.image = image

        super.init(router: router)
    }
}
