//
//  TestUserService.swift
//  Netology iOS homeworks
//
//  Created by Александр on 11.12.2021.
//

import Foundation

class TestUserService: UserService {

    private let testUser = User(fullName: "testUserName".localized, avatarName: "Cat", status: "testUserStatus".localized)
    
    func user(name: String) -> User? {
        testUser
    }
}
