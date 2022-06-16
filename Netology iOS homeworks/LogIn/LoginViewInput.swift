//
//  LoginViewInput.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 29.01.2022.
//

import Foundation

protocol LoginViewInput: AnyObject {
    func showLogInError(title: String, message: String?)
    func autoAuthorizationWith(login: Login, password: Password)
}
