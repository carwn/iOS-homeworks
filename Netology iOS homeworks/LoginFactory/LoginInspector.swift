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
    func check(login: String, password: String, completion: @escaping (Result<[Post], LoginInspectorError>) -> Void) {
        FirebaseAuth.Auth.auth().signIn(withEmail: login, password: password) { result, error in
            if result != nil {
                completion(.success(Post.postsExample))
            } else if let error = error {
                completion(.failure(.otherError(error)))
            }
        }
    }
    
    func createUser(withEmail email: String, password: String, completion: @escaping (Result<FirebaseAuth.User, LoginInspectorError>) -> Void) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                completion(.success(result.user))
            } else if let error = error {
                completion(.failure(.otherError(error)))
            }
        }
    }
}
