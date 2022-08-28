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
        stack.spacing = Constants.defaultOffset
        stack.alignment = .center
        return stack
    }()
    private let showAlertButton = SystemButton(title: "Show alert")
    private let titleLabel = UILabel(text: "Loading...")
    private let orbitalPeriodLabel = UILabel(text: "Loading...")
    private let tableView = UITableView()
    
    private var residents: [People] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        showAlertButton.onTapHandler = { [weak self] in
            self?.showAlertButtonPressed()
        }
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startNetworkRequest()
    }
    
    private func setupViews() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(showAlertButton)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(orbitalPeriodLabel)
        view.addSubview(stackView)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.defaultOffset),
                                     stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.defaultOffset),
                                     stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.defaultOffset),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Constants.defaultOffset),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
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
                    print(error)
                    self.titleLabel.text = "error"
                    self.present(UIAlertController.infoAlert(title: "Error", message: error.localizedDescription), animated: true)
                }
            }
        }
        networkService.getPlanet(from: TestURLs.task2_2) { [weak self] result in
            switch result {
            case .success(let planet):
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.orbitalPeriodLabel.text = planet.orbitalPeriod
                    self.getResidents(urls: planet.residents)
                }
            case .failure(let error):
                guard let self = self else { return }
                DispatchQueue.main.async {
                    print(error)
                    self.orbitalPeriodLabel.text = "error"
                    self.present(UIAlertController.infoAlert(title: "Error", message: error.localizedDescription), animated: true)
                }
            }
        }
    }
    
    private func getResidents(urls: [URL]) {
        DispatchQueue.global().async { [weak self] in
            var residents: [People] = []
            let group = DispatchGroup()
            for residentURL in urls {
                guard let self = self else { return }
                group.enter()
                self.networkService?.getPeople(from: residentURL, completion: { [weak self] result in
                    switch result {
                    case .success(let people):
                        residents.append(people)
                    case .failure(let error):
                        self?.present(UIAlertController.infoAlert(title: "Error", message: error.localizedDescription), animated: true)
                    }
                    group.leave()
                })
            }
            group.wait()
            DispatchQueue.main.async {
                self?.residents = residents
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

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = residents[indexPath.row].name
        return cell
    }
}

extension InfoViewController {
    enum Constants {
        static let defaultOffset: CGFloat = 8
    }
}
