//
//  LoginViewControllerDelegate.swift
//  Netology iOS homeworks
//
//  Created by Александр on 01.01.2022.
//

import Foundation
import StorageService

enum LoginViewControllerDelegateError: LocalizedError {
    case unknowUserNameOrPassword
    
    var errorDescription: String? {
        switch self {
        case .unknowUserNameOrPassword:
            return "Неверный логин или пароль"
        }
    }
}

protocol LoginViewControllerDelegate: AnyObject {
    func check(login: String, password: String, complition: (Result<[StorageService.Post], LoginViewControllerDelegateError>) -> Void)
}
