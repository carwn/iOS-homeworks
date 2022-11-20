//
//  UIColor+createColor.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 03.10.2022.
//

import UIKit

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}
