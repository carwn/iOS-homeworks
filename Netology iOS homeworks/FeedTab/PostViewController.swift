//
//  PostViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 27.08.2021.
//

import UIKit

class PostViewController: UIViewController {
    
    struct Post {
        let title: String
    }
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = post?.title ?? "empty post"
        view.backgroundColor = .systemGreen
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(showInfoButtonPressed))
    }
    
    @objc private func showInfoButtonPressed() {
        let infoVC = InfoViewController()
        present(infoVC, animated: true, completion: nil)
    }
}
