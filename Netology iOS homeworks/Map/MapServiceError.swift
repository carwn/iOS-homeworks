//
//  MapServiceError.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 28.08.2022.
//

import Foundation

enum MapServiceError: LocalizedError {
    case locationAccessDenied
    case other(Error)
    
    var errorDescription: String? {
        switch self {
        case .locationAccessDenied:
            return "Нет доступа к геопозиции"
        case .other(let error):
            return error.localizedDescription
        }
    }
}
