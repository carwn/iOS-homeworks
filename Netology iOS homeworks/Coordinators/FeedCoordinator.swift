//
//  FeedCoordinator.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 26.01.2022.
//

import UIKit

class FeedCoordinator: TabBarCoordinator {
    
    var rootViewController: UIViewController {
        navigationController
    }
    
    private let wordChecker: WordChecker
    private let networkService: NetworkService
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: feedViewController)
        navigationController.tabBarItem = UITabBarItem(title: "feedTabTitle".localized,
                                                       image: UIImage(systemName: "f.square"),
                                                       selectedImage: UIImage(systemName: "f.square.fill"))
        return navigationController
    }()
    
    private lazy var feedViewController: UIViewController = {
        let feedViewController = FeedViewController(wordChecker: wordChecker, coordinator: self)
        feedViewController.onPushPostViewControllerButtonPressed = { [weak self] post in
            self?.pushPostViewController(post: post)
        }
        return feedViewController
    }()
    
    init(wordChecker: WordChecker, networkService: NetworkService) {
        self.wordChecker = wordChecker
        self.networkService = networkService
    }
    
    func start() {
        
    }
    
    private func pushPostViewController(post: PostViewController.Post) {
        let postVC = PostViewController()
        postVC.post = post
        postVC.onShowInfoButtonPressed = { [weak self] in
            self?.showInfoViewController()
        }
        navigationController.pushViewController(postVC, animated: true)
    }
    
    private func showInfoViewController() {
        let infoVC = InfoViewController()
        infoVC.networkService = networkService
        navigationController.present(infoVC, animated: true, completion: nil)
    }
}
