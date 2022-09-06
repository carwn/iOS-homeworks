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
    
    // MARK: - Private Methods
    private func showProfile(login: Login) {
        showProfileViewClosure?(ShowProfileViewParams(userName: login, posts: Post.postsExample))
    }
}

extension LoginViewPresenter: LoginViewOutput {
    func viewDidLoad() {
        if let authorizedUser = delegate.authorizedUser {
            viewController?.autoAuthorizationWith(login: authorizedUser.login, password: authorizedUser.password)
        }
    }
    
    func logInButtonPressed(login: String?, password: String?) {
        guard let userName = login, !userName.isEmpty else {
            viewController?.showLogInError(title: "noUserNameError".localized, message: nil)
            return
        }
        guard let password = password, !password.isEmpty else {
            viewController?.showLogInError(title: "noPasswordError".localized, message: nil)
            return
        }
        delegate.check(login: userName, password: password) { [weak self] result in
            switch result {
            case .success(let userName):
                self?.showProfile(login: userName)
            case .failure(let error):
                self?.viewController?.showLogInError(title: "error".localized, message: error.localizedDescription)
            }
        }
    }
    
    func createUserButtonPressed(withEmail email: String?, password: String?) {
        guard let email = email, !email.isEmpty else {
            viewController?.showLogInError(title: "noeMailError".localized, message: nil)
            return
        }
        guard let password = password, !password.isEmpty else {
            viewController?.showLogInError(title: "noPasswordError".localized, message: nil)
            return
        }
        delegate.createUser(withEmail: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.viewController?.showLogInError(title: "userSuccessCreationMessage".localized, message: user.displayName)
            case .failure(let error):
                self?.viewController?.showLogInError(title: "error".localized, message: error.localizedDescription)
            }
        }
    }
}
