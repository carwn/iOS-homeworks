//
//  UIColor+colors.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 03.10.2022.
//

import UIKit

extension UIColor {
    static let myBackgroundColor = createColor(lightMode: .white, darkMode: .black)
    static let myTextColor = createColor(lightMode: .black, darkMode: .white)
    static let myTextFieldsViewBorderColor = createColor(lightMode: .lightGray, darkMode: .white)
}
