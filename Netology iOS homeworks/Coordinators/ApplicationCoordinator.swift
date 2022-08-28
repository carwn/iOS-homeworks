//
//  ApplicationCoordinator.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 26.01.2022.
//

import Foundation
import UIKit

final class ApplicationCoordinator: NSObject, Coordinator {

    private var window: UIWindow?
    private let scene: UIWindowScene

    private let tabBarController: UITabBarController
    
    private let feedCoordinator: FeedCoordinator
    private let profileCoordinator: ProfileCoordinator
    private let multimediaCoordinator: MultimediaCoordinator
    private let storedPostsCoordinator: StoredPostsCoordinator
    private let mapCoordinator: MapCoordinator
    
    private let factory: LoginFactory
    private let loginInspector: LoginInspector
    private let wordChecker = WordChecker()
    private let multimediaStore = MultimediaStore()
    private let networkService = NetworkService()
    
    init(scene: UIWindowScene, factory: LoginFactory) {
        self.scene = scene
        self.factory = factory
        tabBarController = UITabBarController()
        loginInspector = factory.makeLoginInspector()
        feedCoordinator = FeedCoordinator(wordChecker: wordChecker, networkService: networkService)
        profileCoordinator = ProfileCoordinator(delegate: loginInspector)
        multimediaCoordinator = MultimediaCoordinator(audioURLs: multimediaStore.audioURLs, youtubeVideos: multimediaStore.youtubeVideos)
        storedPostsCoordinator = StoredPostsCoordinator()
        mapCoordinator = MapCoordinator()
        tabBarController.setViewControllers([feedCoordinator.rootViewController,
                                             profileCoordinator.rootViewController,
                                             multimediaCoordinator.rootViewController,
                                             storedPostsCoordinator.rootViewController,
                                             mapCoordinator.rootViewController], animated: false)
        super.init()
        tabBarController.delegate = self
        tabBarController.tabBar.backgroundColor = .systemBackground
    }

    func start() {
        initWindow()
        if let selectedViewController = tabBarController.selectedViewController {
            startFlow(viewController: selectedViewController)
        }
    }

    private func initWindow() {
        let window = UIWindow(windowScene: scene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    private func startFeedFlow() {
        feedCoordinator.start()
    }

    private func startProfileFlow() {
        profileCoordinator.start()
    }
    
    private func startMultimediaFlow() {
        multimediaCoordinator.start()
    }
    
    private func startStoredPostsCoordinatorFlow() {
        storedPostsCoordinator.start()
    }
    
    private func startMapFlow() {
        mapCoordinator.start()
    }
    
    private func startFlow(viewController: UIViewController) {
        switch viewController {
        case profileCoordinator.rootViewController:
            startProfileFlow()
        case feedCoordinator.rootViewController:
            startFeedFlow()
        case multimediaCoordinator.rootViewController:
            startMultimediaFlow()
        case storedPostsCoordinator.rootViewController:
            startStoredPostsCoordinatorFlow()
        case mapCoordinator.rootViewController:
            startMapFlow()
        default:
            break
        }
    }
}

extension ApplicationCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        startFlow(viewController: viewController)
    }
}
