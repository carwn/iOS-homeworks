//
//  CurrentUserService.swift
//  Netology iOS homeworks
//
//  Created by Александр on 11.12.2021.
//

import Foundation

class CurrentUserService {
    private let storedUser = User(fullName: "storedUserName".localized, avatarName: "Cat", status: "storedUserStatus".localized)
}

extension CurrentUserService: UserService {
    func user(name: String) -> User? {
        storedUser.fullName == name ? storedUser : nil
    }
}
