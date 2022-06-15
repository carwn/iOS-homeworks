//
//  StoredPostsCoordinator.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 15.06.2022.
//

import UIKit

class StoredPostsCoordinator {
    
    private let navigationController: UINavigationController
    private let storedPostsViewController: StoredPostsViewController
    
    init() {
        let storedPostsViewController = StoredPostsViewController(style: .grouped)
        storedPostsViewController.tabBarItem = UITabBarItem(title: "Stored posts",
                                                            image: UIImage(systemName: "star"),
                                                            selectedImage: UIImage(systemName: "star.fill"))
        navigationController = UINavigationController(rootViewController: storedPostsViewController)
        self.storedPostsViewController = storedPostsViewController
    }
}

extension StoredPostsCoordinator: TabBarCoordinator {
    
    var rootViewController: UIViewController {
        navigationController
    }
    
    func start() {
        
    }
}
