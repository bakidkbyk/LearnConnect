//
//  LoginTest.swift
//  LearnConnectTests
//
//  Created by Melih Avcı on 28.11.2024.
//

import XCTest
@testable import LearnConnect

class LoginViewModelTests: XCTestCase {
    var authService: AuthService!

    override func setUpWithError() throws {
        authService = AuthService()
    }

    override func tearDownWithError() throws {
        authService = nil
    }

    func testLoginSuccess() {
        let expectation = self.expectation(description: "Giriş bilgileri doğru olmalıdır")
        
        authService.login(username: "testuser", password: "testpassword") { success in
            XCTAssertTrue(success)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoginFailure() {
        let expectation = self.expectation(description: "Giriş yanlış kimlik bilgileriyle başarısız olmalı")
        
        authService.login(username: "wronguser", password: "wrongpassword") { success in
            XCTAssertFalse(success)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}



