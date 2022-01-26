//
//  TabBarCoordinator.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 26.01.2022.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    private let indexInTabBar: Int
    private weak var tabBarController: UITabBarController?
    
    init(indexInTabBar: Int, tabBarController: UITabBarController) {
        self.indexInTabBar = indexInTabBar
        self.tabBarController = tabBarController
    }
    
    func start() {
        tabBarController?.selectedIndex = indexInTabBar
    }
    
    var rootViewController: UIViewController? {
        nil
    }
}
