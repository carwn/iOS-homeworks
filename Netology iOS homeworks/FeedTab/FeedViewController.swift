//
//  FeedViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 27.08.2021.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {

    // MARK: - Public Properties
    var onPushPostViewControllerButtonPressed: ((PostViewController.Post) -> Void)?
    
    // MARK: - Private Properties
    private lazy var inputTextView: InputTextView = {
        let inputTextView = InputTextView()
        inputTextView.delegate = self
        return inputTextView
    }()

    private lazy var buttonsStackView: UIStackView = {
        func pushPostViewControllerButton(number: Int) -> SystemButton {
            let button = SystemButton(title: "PushPostViewController #\(number)")
            button.onTapHandler = { [weak self] in
                self?.pushPostViewControllerButtonPressed()
            }
            return button
        }
        let stack = UIStackView(arrangedSubviews: [pushPostViewControllerButton(number: 1),
                                                   pushPostViewControllerButton(number: 2)])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    private lazy var inputTextStackView: UIStackView = {
        let inputTextStackView = UIStackView(arrangedSubviews: [inputTextView, spinner, resultLabel])
        inputTextStackView.axis = .vertical
        inputTextStackView.spacing = 10
        return inputTextStackView
    }()

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()

    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    private let wordChecker: WordChecker
    private weak var coordinator: FeedCoordinator?

    // MARK: - Initializers
    init(wordChecker: WordChecker, coordinator: FeedCoordinator) {
        self.wordChecker = wordChecker
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "FeedViewController"
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setupViewsAndConstraints()
    }

    // MARK: - Private Methods
    private func setupViewsAndConstraints() {
        let container = UIView()
        container.addSubview(buttonsStackView)
        container.addSubview(inputTextStackView)
        view.addSubview(container)
        container.center(in: view)

        buttonsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        inputTextStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(buttonsStackView.snp_bottomMargin).offset(25)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(view).multipliedBy(0.85)
        }
    }

    private func updateResultLabelText(_ result: WordChecker.Result) {
        let color: UIColor = {
            switch result {
            case .correct:
                return .green
            case .notCorrect, .checkError:
                return .red
            }
        }()
        self.resultLabel.textColor = color
        self.resultLabel.text = result.description
    }

    @objc
    private func pushPostViewControllerButtonPressed() {
        let post = PostViewController.Post(title: "Hello")
        onPushPostViewControllerButtonPressed?(post)
    }
}

extension FeedViewController: InputTextViewDelegate {
    func userInputedText(text: String?) {
        guard let text = text, !text.isEmpty else {
            present(UIAlertController.infoAlert(title: "Не введен текст"), animated: true)
            return
        }
        spinner.startAnimating()
        resultLabel.isHidden = true
        wordChecker.check(word: text) { [weak self] result in
            guard let self = self else {
                return
            }
            self.spinner.stopAnimating()
            self.updateResultLabelText(result)
            self.resultLabel.isHidden = false
        }
    }
}
