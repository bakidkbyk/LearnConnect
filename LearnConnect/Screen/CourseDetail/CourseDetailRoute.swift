//
//  CourseDetailRoute.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 27.11.2024.
//

import UIKit

protocol CourseDetailRoute {
    func pushCourseDetailRoute(title: String, image: UIImage)
}

extension CourseDetailRoute where Self: RouterProtocol {
    
    func pushCourseDetailRoute(title: String, image: UIImage) {
        let router = CourseDetailRouter()
        let viewModel = CourseDetailViewModel(title: title, image: image, router: router)
        let viewController = CourseDetailViewController(viewModel: viewModel)


        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition

        viewController.hidesBottomBarWhenPushed = true

        open(viewController, transition: transition)
    }
}
