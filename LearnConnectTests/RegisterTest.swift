//
//  RegisterTest.swift
//  LearnConnectTests
//
//  Created by Melih Avcı on 28.11.2024.
//

import XCTest
@testable import LearnConnect

final class RegisterTest: XCTestCase {

    var authService: AuthService!

       override func setUpWithError() throws {
           authService = AuthService()
       }

       override func tearDownWithError() throws {
           authService = nil
       }

       func testRegisterSuccess() {
           let expectation = self.expectation(description: "Kayıt bilgileri doğru olmalıdır")
           
           authService.register(username: "newuser", password: "newpassword") { success in
               XCTAssertTrue(success)
               expectation.fulfill()
           }
           
           waitForExpectations(timeout: 1, handler: nil)
       }

       func testRegisterFailure() {
           let expectation = self.expectation(description: "Giriş yanlış kimlik bilgileriyle başarısız olmalı")
           
           authService.register(username: "existinguser", password: "newpassword") { success in
               XCTAssertFalse(success)
               expectation.fulfill()
           }
           
           waitForExpectations(timeout: 1, handler: nil)
       }
}

