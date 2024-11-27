//
//  HomeViewRouter.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

protocol HomeViewRouterProtocol: ProfileRoute, CourseDetailRoute { }

final class HomeViewRouter: Router, HomeViewRouterProtocol {}
