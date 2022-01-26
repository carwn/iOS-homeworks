//
//  ApplicationCoordinator.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 26.01.2022.
//

import Foundation
import UIKit

final class ApplicationCoordinator: BaseCoordinator, Coordinator {

    private var window: UIWindow?
    private let scene: UIWindowScene

    private let tabBarController: UITabBarController = {
        let tabBarController = UITabBarController()
        return tabBarController
    }()
    
    private let factory: LoginFactory = DefaultLoginFactory()
    private lazy var loginInspector: LoginInspector = {
        factory.makeLoginInspector()
    }()
    private let wordChecker = WordChecker()
    
    init(scene: UIWindowScene) {
        self.scene = scene
        super.init()
    }

    func start() {
        initWindow()
        let feedCoordinator = FeedCoordinator(wordChecker: wordChecker, indexInTabBar: 0, tabBarController: tabBarController)
        addDependency(feedCoordinator)
        let profileCoordinator = ProfileCoordinator(delegate: loginInspector, indexInTabBar: 1, tabBarController: tabBarController)
        addDependency(profileCoordinator)
        tabBarController.setViewControllers(childCoordinators.compactMap { $0 as? TabBarCoordinator }.compactMap { $0.rootViewController }, animated: false)
        startFeedFlow()
    }

    private func initWindow() {
        let window = UIWindow(windowScene: scene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    private func startFeedFlow() {
        childCoordinators.first(where: { $0 is FeedCoordinator } )?.start()
    }

    private func startProfileFlow() {
        childCoordinators.first(where: { $0 is ProfileCoordinator })?.start()
    }
}
