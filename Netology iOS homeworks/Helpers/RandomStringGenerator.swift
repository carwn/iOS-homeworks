//
//  RandomStringGenerator.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 07.02.2022.
//

import Foundation

enum RandomStringGeneratorError: LocalizedError {
    case charactersArrayIsEmpty, minLengthIsMoreThenMaxLingth, failedToGetRandomCharacter
    var errorDescription: String? {
        switch self {
        case .charactersArrayIsEmpty:
            return "Массив символов пуст"
        case .minLengthIsMoreThenMaxLingth:
            return "Минимальная длинна больше максимальной"
        case .failedToGetRandomCharacter:
            return "Не удалось получить случайный символ"
        }
    }
}

class RandomStringGenerator {
    var characters = String.myCharacters
    var minLength = 2
    var maxLength = 4
    
    func generate() throws -> String {
        guard minLength <= maxLength else {
            throw RandomStringGeneratorError.minLengthIsMoreThenMaxLingth
        }
        guard !characters.isEmpty else {
            throw RandomStringGeneratorError.charactersArrayIsEmpty
        }
        
        var result = ""
        for _ in 0..<Int.random(in: minLength...maxLength) {
            if let randomCharacter = characters.randomElement() {
                result.append(randomCharacter)
            } else {
                throw RandomStringGeneratorError.failedToGetRandomCharacter
            }
        }
        return result
    }
}
