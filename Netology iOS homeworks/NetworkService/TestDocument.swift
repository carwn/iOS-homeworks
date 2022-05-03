//
//  TestDocument.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 29.04.2022.
//

import Foundation

struct TestDocument {
    
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    
    init(userId: Int, id: Int, title: String, completed: Bool) {
        self.userId = userId
        self.id = id
        self.title = title
        self.completed = completed
    }
    
    init?(dictionary: [String: Any]) {
        guard
            let userId = dictionary["userId"] as? Int,
            let id = dictionary["id"] as? Int,
            let title = dictionary["title"] as? String,
            let completed = dictionary["completed"] as? Bool
        else {
            return nil
        }
        self.init(userId: userId, id: id, title: title, completed: completed)
    }
}
