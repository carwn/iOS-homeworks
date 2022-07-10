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
    private let localDatabaseEncryptionKeyKeychainKey = "localDatabaseEncryptionKey"
    
    var localDatabaseEncryptionKey: Data? {
        do {
            if let key = try localDatabaseEncryptionKeyFromKeycahin() {
                print("SafeStore. Return stored localDatabaseEncryptionKey")
                return key
            } else {
                let newKey = generateNewLocalDatabaseEncryptionKey()
                try saveLocalDatabaseEncryptionKeyToKeycahin(newKey)
                print("SafeStore. Return new localDatabaseEncryptionKey")
                return newKey
            }
        } catch {
            print(error)
            return nil
        }
    }
    
    func deleteLocalDatabaseEncryptionKey() {
        do {
            try saveLocalDatabaseEncryptionKeyToKeycahin(nil)
        } catch {
            print(error)
        }
    }
    
    private func localDatabaseEncryptionKeyFromKeycahin() throws -> Data? {
        try keychain.getData(localDatabaseEncryptionKeyKeychainKey)
    }
    
    private func saveLocalDatabaseEncryptionKeyToKeycahin(_ key: Data?) throws {
        if let key = key {
            try keychain.set(key, key: localDatabaseEncryptionKeyKeychainKey)
        } else {
            try keychain.remove(localDatabaseEncryptionKeyKeychainKey)
        }
    }
    
    private func generateNewLocalDatabaseEncryptionKey() -> Data {
        var key = Data(count: 64)
        _ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
            SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
        }
        return key
    }
}
