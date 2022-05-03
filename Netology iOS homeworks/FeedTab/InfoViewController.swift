//
//  InfoViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр on 28.08.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.center(in: view)
        addShowAlertButton()
    }
    
    private func addShowAlertButton() {
        let button = SystemButton(title: "Show alert") { [weak self] in
            self?.showAlertButtonPressed()
        }
        stackView.addArrangedSubview(button)
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
