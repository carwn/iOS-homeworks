//
//  WordChecker.swift
//  Netology iOS homeworks
//
//  Created by Александр on 16.01.2022.
//

import Foundation

class WordChecker {

    typealias CheckCallback = (Result) -> Void
    
    enum Result: CustomStringConvertible {
        case correct, notCorrect, checkError

        var description: String {
            switch self {
            case .correct:
                return "correct".localized
            case .notCorrect:
                return "incorrect".localized
            case .checkError:
                return "checkError".localized
            }
        }
    }

    // MARK: - Private Properties
    private let correctWord = "Hello"

    // MARK: - Public Methods
    func check(word: String, _ callback: @escaping CheckCallback) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            if let self = self {
                callback(word == self.correctWord ? .correct : .notCorrect)
            } else {
                callback(.checkError)
            }
        }
    }
}
