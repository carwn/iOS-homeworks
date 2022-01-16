//
//  FeedViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 27.08.2021.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {

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
        container.addSubview(inputTextView)
        view.addSubview(container)
        container.center(in: view)

        buttonsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        inputTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(buttonsStackView.snp_bottomMargin).offset(30)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(view).multipliedBy(0.85)
        }
    }

    @objc
    private func pushPostViewControllerButtonPressed() {
        let post = PostViewController.Post(title: "Hello")
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
}

extension FeedViewController: InputTextViewDelegate {
    func userInputedText(text: String?) {
        print(text as Any)
    }
}
