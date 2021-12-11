//
//  CurrentUserService.swift
//  Netology iOS homeworks
//
//  Created by Александр on 11.12.2021.
//

import Foundation

class CurrentUserService {
    private let storedUser = User(fullName: "Hipster Cat", avatarName: "Cat", status: "Chill")
}

extension CurrentUserService: UserService {
    func user(name: String) -> User? {
        storedUser.fullName == name ? storedUser : nil
    }
}
