//
//  LoginViewOutput.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 29.01.2022.
//

import Foundation
import StorageService

struct ShowProfileViewParams {
    let userName: String
    let posts: [Post]
}

protocol LoginViewOutput: AnyObject {
    var showProfileViewClosure: ((ShowProfileViewParams) -> Void)? { set get }
    func logInButtonPressed(login: String?, password: String?)
    func createUserButtonPressed(withEmail: String?, password: String?)
}
