//
//  FeedCoordinator.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 26.01.2022.
//

import UIKit

class FeedCoordinator: TabBarCoordinator {
    
    override var rootViewController: UIViewController? {
        feedViewController
    }
    
    private let feedViewController: UIViewController
    
    init(wordChecker: WordChecker, indexInTabBar: Int, tabBarController: UITabBarController) {
        feedViewController = UINavigationController(rootViewController: FeedViewController(wordChecker: wordChecker))
        feedViewController.tabBarItem = UITabBarItem(title: "Feed",
                                                     image: UIImage(systemName: "f.square"),
                                                     selectedImage: UIImage(systemName: "f.square.fill"))
        super.init(indexInTabBar: indexInTabBar, tabBarController: tabBarController)
    }
}
