//
//  LoginInspector.swift
//  Netology iOS homeworks
//
//  Created by Александр on 01.01.2022.
//

import Foundation
import StorageService

class LoginInspector {

}

extension LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String, complition: (Result<[Post], LoginViewControllerDelegateError>) -> Void) {
        if LoginChecker.shared.check(login: login, password: password) {
            complition(.success(Post.postsExample))
        } else {
            complition(.failure(.unknowUserNameOrPassword))
        }
    }
}
