//
//  RealmAuthorizedUserService.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 09.06.2022.
//

import Foundation
import RealmSwift

class RealmAuthorizedUserService {
    private var realm: Realm? {
        try? Realm()
    }
    
    private var authorizedUser: RealmAuthorizedUser? {
        realm?.objects(RealmAuthorizedUser.self).first
    }
}

extension RealmAuthorizedUserService: AuthorizedUserService {
    
    func successfulAuthorization(login: Login) {
        if let authorizedUser = authorizedUser, authorizedUser.login == login {
            realm?.beginWrite()
            authorizedUser.lastLoginDate = Date()
            let _ = try? realm?.commitWrite()
        } else {
            logoff()
            let _ = try? realm?.write({
                let user = RealmAuthorizedUser()
                user.login = login
                let now = Date()
                user.firstLoginDate = now
                user.lastLoginDate = now
                realm?.add(user)
            })
        }
    }
    
    func logoff() {
        guard let authorizedUser = authorizedUser else {
            return
        }
        realm?.delete(authorizedUser)
    }
    
    var authorizedUserInfo: AuthorizedUserInfo? {
        guard let authorizedUser = authorizedUser else {
            return nil
        }
        return AuthorizedUserInfo(login: authorizedUser.login,
                                  firstLogin: authorizedUser.firstLoginDate,
                                  lastLogin: authorizedUser.lastLoginDate)
    }
}
