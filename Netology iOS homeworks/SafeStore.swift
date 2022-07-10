//
//  SafeStore.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 10.07.2022.
//

import Foundation
import KeychainAccess

class SafeStore {
    static let shared = SafeStore()
    private init() {}
    
    private let keychain = Keychain(service: "com.example.netology.shelihov.netologyHomeworks")
    private let localDataBaseEncryptionKeyKeychainKey = "localDataBaseEncryptionKey"
    
    var localDataBaseEncryptionKey: Data? {
        do {
            if let key = try localDataBaseEncryptionKeyFromKeycahin() {
                print("SafeStore. Return stored localDataBaseEncryptionKey")
                return key
            } else {
                let newKey = generateNewLocalDataBaseEncryptionKey()
                try saveLocalDataBaseEncryptionKeyToKeycahin(newKey)
                print("SafeStore. Return new localDataBaseEncryptionKey")
                return newKey
            }
        } catch {
            print(error)
            return nil
        }
    }
    
    func deleteLocalDataBaseEncryptionKey() {
        do {
            try saveLocalDataBaseEncryptionKeyToKeycahin(nil)
        } catch {
            print(error)
        }
    }
    
    private func localDataBaseEncryptionKeyFromKeycahin() throws -> Data? {
        try keychain.getData(localDataBaseEncryptionKeyKeychainKey)
    }
    
    private func saveLocalDataBaseEncryptionKeyToKeycahin(_ key: Data?) throws {
        if let key = key {
            try keychain.set(key, key: localDataBaseEncryptionKeyKeychainKey)
        } else {
            try keychain.remove(localDataBaseEncryptionKeyKeychainKey)
        }
    }
    
    private func generateNewLocalDataBaseEncryptionKey() -> Data {
        var key = Data(count: 64)
        _ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
            SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
        }
        return key
    }
}
