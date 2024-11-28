//
//  SubscribeRouter.swift
//  LearnConnect
//
//  Created by Melih Avcı on 26.11.2024.
//

import Foundation

protocol SubscribeRouterProtocol: CourseDetailRoute { }

final class SubscribeRouter: Router, SubscribeRouterProtocol {}

