//
//  RealmAuthorizedUser.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 09.06.2022.
//

import Foundation
import RealmSwift

class RealmAuthorizedUser: Object {
    @Persisted var login: Login
    @Persisted var password: Password
    @Persisted var firstLoginDate: Date
    @Persisted var lastLoginDate: Date
}
