//
//  SceneDelegate.swift
//  Netology iOS homeworks
//
//  Created by Александр on 22.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    private let factory = DefaultLoginFactory(authorizedUserService: RealmAuthorizedUserService())
    private var appCoordinator: ApplicationCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        appCoordinator = ApplicationCoordinator(scene: scene, factory: factory)
        appCoordinator.start()
    }
}

