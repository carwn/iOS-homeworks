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
    init(authorizedUserService: AuthorizedUserService) {
        self.authorizedUserService = authorizedUserService
    }
    
    private let authorizedUserService: AuthorizedUserService
}

extension LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String, completion: @escaping (Result<String, LoginInspectorError>) -> Void) {
        FirebaseAuth.Auth.auth().signIn(withEmail: login, password: password) { [weak self] result, error in
            if result != nil {
                self?.authorizedUserService.successfulAuthorization(login: login)
                completion(.success(login))
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
    
    var authorizedUserLogin: Login? {
        authorizedUserService.authorizedUserInfo?.login
    }
}
