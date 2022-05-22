//
//  FirebaseAuthTests.swift
//  Netology iOS homeworksTests
//
//  Created by Александр Шелихов on 08.05.2022.
//

import XCTest
import FirebaseAuth

class FirebaseAuthTests: XCTestCase {
    
    private let testEmail = "test@test.com"
    private let testPassword = "password"
    
    override func setUpWithError() throws {
        try deleteUser()
    }
    
    override func tearDownWithError() throws {
        try deleteUser()
    }
    
    func testExample() throws {
        
        // проверяем, что не авторизованы
        XCTAssertNil(currentUser)
        
        let signInExpectation = expectation(description: "signInExpectation")
        FirebaseAuth.Auth.auth().signIn(withEmail: testEmail, password: testPassword) { [weak self] result, error in
            
            // поскольку пользователя на сервере нет, должна быть ошибка
            XCTAssertNotNil(error)
            XCTAssertNil(result)
            guard let self = self else {
                return
            }
            
            FirebaseAuth.Auth.auth().createUser(withEmail: self.testEmail, password: self.testPassword) { [weak self] result, error in
                // пользователь должен создаться
                XCTAssertNil(error)
                XCTAssertNotNil(result)
                guard let self = self else {
                    return
                }
                
                // делаем signOut чтобы попробовать авторизоваться заново
                XCTAssertNotNil(try? FirebaseAuth.Auth.auth().signOut())
                
                FirebaseAuth.Auth.auth().signIn(withEmail: self.testEmail, password: self.testPassword) { [weak self] result, error in
                    // авторизация прошла успешно
                    XCTAssertNil(error)
                    XCTAssertNotNil(result)
                    
                    // проверяем пользователя
                    guard let self = self else {
                        return
                    }
                    let currentUser = self.currentUser
                    XCTAssertNotNil(currentUser)
                    XCTAssertEqual(currentUser?.email, self.testEmail)
                    signInExpectation.fulfill()
                }
            }
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    private var currentUser: User? {
        FirebaseAuth.Auth.auth().currentUser
    }
    
    private func deleteUser() throws {
        let deleteUserExpectation = expectation(description: "deleteUserExpectation")
        FirebaseAuth.Auth.auth().signIn(withEmail: testEmail, password: testPassword) { result, error in
            if let currentUser = self.currentUser {
                currentUser.delete()
                try? FirebaseAuth.Auth.auth().signOut()
                deleteUserExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
