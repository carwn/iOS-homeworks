//
//  ProfileCoordinator.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 26.01.2022.
//

import UIKit
import StorageService

class ProfileCoordinator: TabBarCoordinator {
    
    var rootViewController: UIViewController {
        navigationController
    }
    
    private let navigationController: UINavigationController
    private let logInViewController: LogInViewController
    
    private let userService: UserService = {
#if DEBUG
        return TestUserService()
#else
        return CurrentUserService()
#endif
    }()
    
    init(delegate: LoginViewControllerDelegate) {
        logInViewController = LogInViewController(delegate: delegate, userService: userService)
        navigationController = UINavigationController(rootViewController: logInViewController)
        navigationController.tabBarItem = UITabBarItem(title: "Profile",
                                                      image: UIImage(systemName: "person"),
                                                      selectedImage: UIImage(systemName: "person.fill"))
        logInViewController.showProfileViewClosure = { [weak self] params in
            self?.showProfile(userName: params.userName, posts: params.posts)
        }
    }
    
    func start() {
        print("ProfileCoordinator start")
    }
    
    private func showProfile(userName: String, posts: [Post]) {
        let profileViewController = ProfileViewController(userService: userService, userName: userName)
        profileViewController.posts = posts
        navigationController.pushViewController(profileViewController, animated: true)
    }
}
