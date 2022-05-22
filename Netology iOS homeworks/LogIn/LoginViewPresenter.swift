//
//  LoginViewPresenter.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 29.01.2022.
//

import Foundation
import StorageService

class LoginViewPresenter {
    
    // MARK: - Public Properties
    weak var viewController: LoginViewInput?
    var showProfileViewClosure: ((ShowProfileViewParams) -> Void)?
    
    // MARK: - Private Properties
    private weak var delegate: LoginViewControllerDelegate!
    
    init(delegate: LoginViewControllerDelegate) {
        self.delegate = delegate
    }
}

extension LoginViewPresenter: LoginViewOutput {
    func logInButtonPressed(login: String?, password: String?) {
        guard let userName = login, !userName.isEmpty else {
            viewController?.showLogInError(title: "Не введено имя пользователя", message: nil)
            return
        }
        guard let password = password, !password.isEmpty else {
            viewController?.showLogInError(title: "Не введен пароль", message: nil)
            return
        }
        delegate.check(login: userName, password: password) { [weak self] result in
            switch result {
            case .success(let posts):
                self?.showProfileViewClosure?(ShowProfileViewParams(userName: userName, posts: posts))
            case .failure(let error):
                self?.viewController?.showLogInError(title: "Ошибка", message: error.localizedDescription)
            }
        }
    }
    
    func createUserButtonPressed(withEmail email: String?, password: String?) {
        guard let email = email, !email.isEmpty else {
            viewController?.showLogInError(title: "Не введен email", message: nil)
            return
        }
        guard let password = password, !password.isEmpty else {
            viewController?.showLogInError(title: "Не введен пароль", message: nil)
            return
        }
        delegate.createUser(withEmail: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.viewController?.showLogInError(title: "Пользователь успешно создан", message: user.displayName)
            case .failure(let error):
                self?.viewController?.showLogInError(title: "Ошибка", message: error.localizedDescription)
            }
        }
    }
}
