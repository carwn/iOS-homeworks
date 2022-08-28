//
//  AuthorizedUserService.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 09.06.2022.
//

import Foundation

protocol AuthorizedUserService {
    
    func successfulAuthorization(login: Login, password: Password)
    func logoff()
    
    var authorizedUserInfo: AuthorizedUserInfo? { get }
}
