//
//  InfoViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр on 28.08.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    var networkService: NetworkService?
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    private let showAlertButton = SystemButton(title: "Show alert")
    private let titleLabel = UILabel(text: "Loading...")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        showAlertButton.onTapHandler = { [weak self] in
            self?.showAlertButtonPressed()
        }
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startNetworkRequest()
    }
    
    private func setupViews() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(showAlertButton)
        stackView.addArrangedSubview(titleLabel)
        view.addSubview(stackView)
        stackView.center(in: view)
    }
    
    private func startNetworkRequest() {
        guard let networkService = networkService else {
            let errorTitle = "Не задан network service"
            assertionFailure(errorTitle)
            present(UIAlertController.infoAlert(title: errorTitle), animated: true)
            return
        }
        networkService.getTestDocument(from: TestURLs.task2_1) { [weak self] result in
            switch result {
            case .success(let document):
                DispatchQueue.main.async {
                    self?.titleLabel.text = document.title
                }
            case .failure(let error):
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.titleLabel.text = "error"
                    self.present(UIAlertController.infoAlert(title: "Error", message: error.localizedDescription), animated: true)
                }
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
