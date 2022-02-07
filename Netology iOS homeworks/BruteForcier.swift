//
//  BruteForcier.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 07.02.2022.
//

import Foundation

class BruteForcier {
    
    enum BruteForceError: Error {
        case timeout
    }
    
    var allCharacters: [String] = (String.letters + String.digits).map { String($0) }
    var timeoutInSeconds = 10
    
    private let testClosure: (String) -> Bool
    private var isTimeout = false
    private var timeoutTimerID: UUID? // защита от ситуации когда после удачного брутфорса метод запускается еще раз пока таймер предыдущего еще не сработал
    
    init(testClosure: @escaping (String) -> Bool) {
        self.testClosure = testClosure
    }
    
    func bruteForce(complition: (String) -> Void) throws {
        setupTimer()
        var currentTestString = generateBruteForce("", fromArray: allCharacters)
        while testClosure(currentTestString) == false {
            if isTimeout {
                throw BruteForceError.timeout
            } else {
                currentTestString = generateBruteForce(currentTestString, fromArray: allCharacters)
            }
        }
        complition(currentTestString)
    }
    
    private func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }
    
    private func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    private func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
                                   : Character("")
    }
    
    private func setupTimer() {
        let timeoutTimerID = UUID()
        self.timeoutTimerID = timeoutTimerID
        self.isTimeout = false
        DispatchQueue.global().asyncAfter(deadline: .nowAfter(seconds: timeoutInSeconds)) { [weak self] in
            guard let self = self else { return }
            if self.timeoutTimerID == timeoutTimerID {
                self.isTimeout = true
            }
        }
    }
}

extension String {
    static let digits = "0123456789"
    static let lowercase = "abcdefghijklmnopqrstuvwxyz"
    static let uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static let punctuation = "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
    static let letters = lowercase + uppercase
    static let printable = digits + letters + punctuation

    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

extension DispatchTime {
    static func nowAfter(seconds: Int) -> DispatchTime {
        .init(uptimeNanoseconds: DispatchTime.now().uptimeNanoseconds + UInt64(1_000_000_000 * seconds))
    }
}
