//
//  UILabel+labelWithText.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 03.05.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
    }
}
