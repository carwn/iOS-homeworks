//
//  Int+likesDescription.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 06.09.2022.
//

import Foundation

extension Int {
    var likesDescription: String {
        String(format: "likes".localized, self)
    }
}
