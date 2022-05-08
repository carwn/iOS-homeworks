//
//  LoginInspector.swift
//  Netology iOS homeworks
//
//  Created by Александр on 01.01.2022.
//

import Foundation
import StorageService
import FirebaseAuth

class LoginInspector {

}

extension LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String, complition: @escaping (Result<[Post], LoginViewControllerDelegateError>) -> Void) {
        FirebaseAuth.Auth.auth().signIn(withEmail: login, password: password) { result, error in
            if result != nil {
                complition(.success(Post.postsExample))
            } else if error != nil {
                complition(.failure(.unknowUserNameOrPassword))
            }
        }
    }
}
