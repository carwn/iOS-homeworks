//
//  InfoViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр on 28.08.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    var networkService: NetworkService?
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startNetworkRequest()
    }
    
    private func addShowAlertButton() {
        let button = SystemButton(title: "Show alert") { [weak self] in
            self?.showAlertButtonPressed()
        }
        stackView.addArrangedSubview(button)
    }
    
    private func startNetworkRequest() {
        guard let networkService = networkService else {
            let errorTitle = "Не задан network service"
            assertionFailure(errorTitle)
            present(UIAlertController.infoAlert(title: errorTitle), animated: true)
            return
        }
        networkService.getTestDocument(from: TestURLs.task2_1) { result in
            switch result {
            case .success(let document):
                print(document)
            case .failure(let error):
                print(error)
            }
        }
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
