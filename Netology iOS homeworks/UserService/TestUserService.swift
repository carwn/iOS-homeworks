//
//  TestUserService.swift
//  Netology iOS homeworks
//
//  Created by Александр on 11.12.2021.
//

import Foundation

class TestUserService: UserService {

    private let testUser = User(fullName: "Mega test user", avatarName: "Cat", status: "Testing...")
    
    func user(name: String) -> User? {
        testUser
    }
}
