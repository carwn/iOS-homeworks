//
//  StoredPostsManagerError.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 27.06.2022.
//

import Foundation

enum StoredPostsManagerError: Error {
    case cantDelete
    case other(error: Error)
}
