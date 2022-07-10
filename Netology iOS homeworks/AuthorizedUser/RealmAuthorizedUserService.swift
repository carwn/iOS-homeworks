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
        guard let encryptionKey = SafeStore.shared.localDatabaseEncryptionKey else {
            return nil
        }
        let configuration = Realm.Configuration(encryptionKey: encryptionKey)
        do {
            return try Realm(configuration: configuration)
        } catch {
            if error.localizedDescription.contains("Realm file decryption failed") {
                removeRealmDatabaseFile()
                return self.realm
            }
            print("Realm init error: \(error)")
            return nil
        }
    }
    
    private var authorizedUser: RealmAuthorizedUser? {
        realm?.objects(RealmAuthorizedUser.self).first
    }
    
    private func removeRealmDatabaseFile() {
        guard let url = Realm.Configuration.defaultConfiguration.fileURL else {
            return
        }
        do {
            try FileManager.default.removeItem(at: url)
            print("Realm database file removed")
        } catch {
            print(error)
        }
    }
}

extension RealmAuthorizedUserService: AuthorizedUserService {
    
    func successfulAuthorization(login: Login, password: Password) {
        if let authorizedUser = authorizedUser, authorizedUser.login == login {
            realm?.beginWrite()
            authorizedUser.lastLoginDate = Date()
            let _ = try? realm?.commitWrite()
        } else {
            logoff()
            let _ = try? realm?.write({
                let user = RealmAuthorizedUser()
                user.login = login
                user.password = password
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
                                  password: authorizedUser.password,
                                  firstLogin: authorizedUser.firstLoginDate,
                                  lastLogin: authorizedUser.lastLoginDate)
    }
}
