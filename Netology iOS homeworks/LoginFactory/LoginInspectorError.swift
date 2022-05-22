//
//  LoginInspectorError.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 22.05.2022.
//

import Foundation

enum LoginInspectorError: LocalizedError {
    
    case otherError(Error)
    
    var errorDescription: String? {
        switch self {
        case .otherError(let error):
            return error.localizedDescription
        }
    }
}
