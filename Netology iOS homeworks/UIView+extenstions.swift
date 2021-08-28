//
//  UIView+extenstions.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 28.08.2021.
//

import UIKit

extension UIView {
    func center(in superview: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
}
