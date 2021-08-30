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
        addPushPostViewControllerButton()
    }
    
    private func addPushPostViewControllerButton() {
        let button = UIButton(type: .system)
        button.setTitle("PushPostViewController", for: .normal)
        button.addTarget(self, action: #selector(pushPostViewControllerButtonPressed), for: .touchUpInside)
        view.addSubview(button)
        button.center(in: view)
    }
    
    @objc func pushPostViewControllerButtonPressed() {
        let post = Post(title: "Hello")
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
}
