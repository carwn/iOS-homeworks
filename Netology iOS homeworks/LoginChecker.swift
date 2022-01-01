//
//  LoginChecker.swift
//  Netology iOS homeworks
//
//  Created by Александр on 01.01.2022.
//

import Foundation

class LoginChecker {
    
    // MARK: - Singleton
    static let shared = LoginChecker()
    private init() { }

    // MARK: - Private Properties
    private let login = "Hipster Cat"
    private let password = "StrongPassword"

    // MARK: - Public Methods
    func check(login: String, password: String) -> Bool {
        self.login.hash == login.hash && self.password.hash == password.hash
    }
}
