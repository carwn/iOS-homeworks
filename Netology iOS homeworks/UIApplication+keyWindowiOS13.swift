//
//  UIApplication+keyWindowiOS13.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 19.09.2021.
//

import UIKit

extension UIApplication {
    var keyWindowiOS13: UIWindow? { UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow}).first
    }
}
