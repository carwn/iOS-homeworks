//
//  ProfileCoordinator.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 26.01.2022.
//

import UIKit

class ProfileCoordinator: TabBarCoordinator {
    
    var rootViewController: UIViewController {
        logInViewController
    }
    
    private let logInViewController: UIViewController
    
    init(delegate: LoginViewControllerDelegate) {
        logInViewController = UINavigationController(rootViewController: LogInViewController(delegate: delegate))
        logInViewController.tabBarItem = UITabBarItem(title: "Profile",
                                                      image: UIImage(systemName: "person"),
                                                      selectedImage: UIImage(systemName: "person.fill"))
    }
    
    func start() {
        print("ProfileCoordinator start")
    }
}
