//
//  UIViewController+showError.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 27.06.2022.
//

import UIKit

extension UIViewController {
    func showError(_ error: Error) {
        present(UIAlertController.errorAlert(message: error.localizedDescription), animated: true)
    }
}
