//
//  LoginRouter.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 24.11.2024.
//

import Foundation

protocol LoginRouterProtocol:RegisterRoute,
                             HomeTabBarRoute {}

final class LoginRouter: Router, LoginRouterProtocol {}
