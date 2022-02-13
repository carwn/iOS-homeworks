//
//  RandomStringGenerator.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 07.02.2022.
//

import Foundation

class RandomStringGenerator {
    var characters = String.myCharacters
    var minLength = 2
    var maxLength = 4
    
    func generate() -> String? {
        guard
            minLength <= maxLength,
            !characters.isEmpty
        else {
            return nil
        }
        var result = ""
        for _ in 0..<Int.random(in: minLength...maxLength) {
            if let randomCharacter = characters.randomElement() {
                result.append(randomCharacter)
            } else {
                return nil
            }
        }
        return result
    }
}
