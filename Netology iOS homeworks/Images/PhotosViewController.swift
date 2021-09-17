//
//  PhotosViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 17.09.2021.
//

import UIKit

class PhotosViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Photo Gallery"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}
