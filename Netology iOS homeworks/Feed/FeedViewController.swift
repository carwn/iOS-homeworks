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
    }
    
    @IBAction func pushPostViewControllerButtonPressed(_ sender: UIButton) {
        let postVC = PostViewController()
        navigationController?.pushViewController(postVC, animated: true)
    }
}
