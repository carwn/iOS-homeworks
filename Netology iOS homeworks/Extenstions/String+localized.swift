//
//  String+localized.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 06.09.2022.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
