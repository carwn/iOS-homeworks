//
//  LoginInspector.swift
//  Netology iOS homeworks
//
//  Created by Александр on 01.01.2022.
//

import Foundation

class LoginInspector {

}

extension LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        LoginChecker.shared.check(login: login, password: password)
    }
}
