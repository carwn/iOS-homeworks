//
//  UIImage+extensions.swift
//  Netology iOS homeworks
//
//  Created by Александр on 12.09.2021.
//

import UIKit

extension UIImage {
    func withAlpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
