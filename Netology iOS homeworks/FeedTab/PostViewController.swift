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
    
    var onShowInfoButtonPressed: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = post?.title ?? "emptyPostTitle".localized
        view.backgroundColor = .systemGreen
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "infoButtonTitle".localized, style: .plain, target: self, action: #selector(showInfoButtonPressed))
    }
    
    @objc private func showInfoButtonPressed() {
        onShowInfoButtonPressed?()
    }
}
