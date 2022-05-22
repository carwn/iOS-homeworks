//
//  LoginViewControllerDelegate.swift
//  Netology iOS homeworks
//
//  Created by Александр on 01.01.2022.
//

import Foundation
import StorageService
import FirebaseAuth

protocol LoginViewControllerDelegate: AnyObject {
    func check(login: String, password: String, completion: @escaping (Result<[StorageService.Post], Error>) -> Void)
    func createUser(withEmail: String, password: String, completion:  @escaping (Result<FirebaseAuth.User, Error>) -> Void)
}
