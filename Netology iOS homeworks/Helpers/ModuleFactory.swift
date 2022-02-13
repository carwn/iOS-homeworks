//
//  ModuleFactory.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 29.01.2022.
//

import Foundation

enum ModuleFactory {
    
    struct LogInModule {
        let presenter: LoginViewOutput
        let view: LogInViewController
    }
    
    static func logInModule(delegate: LoginViewControllerDelegate) -> LogInModule {
        let presenter = LoginViewPresenter(delegate: delegate)
        let view = LogInViewController(presenter: presenter)
        presenter.viewController = view
        return LogInModule(presenter: presenter, view: view)
    }
}
