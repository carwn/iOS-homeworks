//
//  SceneDelegate.swift
//  Netology iOS homeworks
//
//  Created by Александр on 22.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private let loginInspector = LoginInspector()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = rootViewController()
        window?.makeKeyAndVisible()
    }
    
    private func rootViewController() -> UIViewController {
        let tabBar = UITabBarController()
        tabBar.setViewControllers([feedViewController(), profileViewController()], animated: false)
        return tabBar
    }
    
    private func feedViewController() -> UIViewController {
        let feedVC = UINavigationController(rootViewController: FeedViewController())
        feedVC.tabBarItem = UITabBarItem(title: "Feed",
                                         image: UIImage(systemName: "f.square"),
                                         selectedImage: UIImage(systemName: "f.square.fill"))
        return feedVC
    }
    
    private func profileViewController() -> UIViewController {
        let profileVC = UINavigationController(rootViewController: LogInViewController(delegate: loginInspector))
        profileVC.tabBarItem = UITabBarItem(title: "Profile",
                                            image: UIImage(systemName: "person"),
                                            selectedImage: UIImage(systemName: "person.fill"))
        return profileVC
    }
}

