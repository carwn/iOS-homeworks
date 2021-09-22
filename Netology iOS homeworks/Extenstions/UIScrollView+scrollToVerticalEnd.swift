//
//  UIScrollView+scrollToVerticalEnd.swift
//  Netology iOS homeworks
//
//  Created by Александр on 12.09.2021.
//

import UIKit

extension UIScrollView {
    func scrollToBottom() {
        scrollRectToVisible(CGRect(x: 0, y: contentSize.height-1, width: 1, height: 1), animated: true)
    }
}
