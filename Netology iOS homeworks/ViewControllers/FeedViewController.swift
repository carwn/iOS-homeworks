//
//  FeedViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 27.08.2021.
//

import UIKit

class FeedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "FeedViewController"
        view.backgroundColor = UIColor(named: "BackgroundColor")
        addStackView()
    }
    
    private func pushPostViewControllerButton(number: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("PushPostViewController #\(number)", for: .normal)
        button.addTarget(self, action: #selector(pushPostViewControllerButtonPressed), for: .touchUpInside)
        return button
    }
    
    private func addStackView() {
        let stack = UIStackView(arrangedSubviews: [pushPostViewControllerButton(number: 1),
                                                   pushPostViewControllerButton(number: 2)])
        stack.axis = .vertical
        stack.spacing = 10
        view.addSubview(stack)
        stack.center(in: view)
    }
    
    @objc func pushPostViewControllerButtonPressed() {
        let post = Post(title: "Hello")
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
}
