//
//  PostViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 27.08.2021.
//

import UIKit

class PostViewController: UIViewController {
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = post?.title ?? "PostViewController"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(showInfoButtonPressed))
    }
    
    @objc
    func showInfoButtonPressed() {
        let infoVC = InfoViewController()
        present(infoVC, animated: true, completion: nil)
    }
}
