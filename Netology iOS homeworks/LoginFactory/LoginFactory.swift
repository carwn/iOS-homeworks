//
//  LoginFactory.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 01.01.2022.
//

import Foundation

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}
