//
//  DefaultLoginFactory.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 01.01.2022.
//

import Foundation

class DefaultLoginFactory: LoginFactory {
    
    init(authorizedUserService: AuthorizedUserService) {
        self.authorizedUserService = authorizedUserService
    }
    
    private let authorizedUserService: AuthorizedUserService
    
    func makeLoginInspector() -> LoginInspector {
        LoginInspector(authorizedUserService: authorizedUserService)
    }
}
