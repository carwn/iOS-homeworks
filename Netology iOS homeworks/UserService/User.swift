//
//  User.swift
//  Netology iOS homeworks
//
//  Created by Александр on 11.12.2021.
//

import Foundation

class User {
    let fullName: String
    let avatarName: String?
    let status: String?
    
    init(fullName: String, avatarName: String?, status: String?) {
        self.fullName = fullName
        self.avatarName = avatarName
        self.status = status
    }
}
