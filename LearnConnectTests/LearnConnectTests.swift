//
//  LearnConnectTests.swift
//  LearnConnectTests
//
//  Created by Melih Avcı on 28.11.2024.
//

import XCTest
@testable import LearnConnect

final class LearnConnectTests: XCTestCase {

}


class AuthService {
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        if username == "testuser" && password == "testpassword" {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func register(username: String, password: String, completion: @escaping (Bool) -> Void) {
        if username == "newuser" && password == "newpassword" {
            completion(true)
        } else {
            completion(false) 
        }
    }
}
