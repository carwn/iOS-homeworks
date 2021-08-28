//
//  InfoViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр on 28.08.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        addShowAlertButton()
    }
    
    private func addShowAlertButton() {
        let button = UIButton(type: .system)
        button.setTitle("Show alert", for: .normal)
        button.addTarget(self, action: #selector(showAlertButtonPressed), for: .touchUpInside)
        view.addSubview(button)
        button.center(in: view)
    }
    
    @objc private func showAlertButtonPressed() {
        let alert = UIAlertController(title: "Alert title", message: "Message text", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("OK button pressed")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            print("Cancel button pressed")
        }))
        present(alert, animated: true, completion: nil)
    }
}
