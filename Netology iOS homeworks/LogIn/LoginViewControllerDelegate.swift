//
//  LoginViewControllerDelegate.swift
//  Netology iOS homeworks
//
//  Created by Александр on 01.01.2022.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func check(login: String, password: String) -> Bool
}
