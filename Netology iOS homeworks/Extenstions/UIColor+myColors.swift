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
    static let myGrayColor = createColor(lightMode: .gray, darkMode: .lightGray)
    static let myTextFieldsViewBorderColor = createColor(lightMode: .lightGray, darkMode: .white)
    static let myDebugGreenColor = createColor(lightMode: .green, darkMode: UIColor(red: 0, green: 90/255, blue: 81/255, alpha: 1))
    
    static let myBlackColor = createColor(lightMode: .black, darkMode: .white)
    static let myWhiteColor = createColor(lightMode: .white, darkMode: .black)
}
