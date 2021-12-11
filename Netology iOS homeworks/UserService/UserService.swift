//
//  UserService.swift
//  Netology iOS homeworks
//
//  Created by Александр on 11.12.2021.
//

import Foundation

protocol UserService {
    func user(name: String) -> User?
}
