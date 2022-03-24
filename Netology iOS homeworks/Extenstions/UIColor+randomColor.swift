//
//  UIColor+randomColor.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 18.02.2022.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        UIColor(red: randomValue, green: randomValue, blue: randomValue, alpha: 1.0)
    }
    
    private static var randomValue: CGFloat {
        CGFloat.random(in: 0...1)
    }
}
