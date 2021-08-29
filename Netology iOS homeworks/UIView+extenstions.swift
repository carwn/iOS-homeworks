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
    
    func setSquareAspectRatio(withHeight height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func constraintToSafeArea(_ safeArea: UILayoutGuide, spacing: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: safeArea.topAnchor, constant: spacing).isActive = true
        safeArea.bottomAnchor.constraint(equalTo: bottomAnchor, constant: spacing).isActive = true
        leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: spacing).isActive = true
        safeArea.trailingAnchor.constraint(equalTo: trailingAnchor, constant: spacing).isActive = true
    }
}
