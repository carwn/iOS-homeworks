//
//  User+avatar.swift
//  Netology iOS homeworks
//
//  Created by Александр on 11.12.2021.
//

import UIKit

extension User {
    var avatar: UIImage? {
        guard let avatarName = avatarName else {
            return nil
        }
        return UIImage(named: avatarName)
    }
}
