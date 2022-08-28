//
//  MapCoordinator.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 28.08.2022.
//

import UIKit

class MapCoordinator {
    
    private let mapViewController: MapViewController
    
    init() {
        let mapViewController = MapViewController(nibName: String(describing: MapViewController.self), bundle: nil)
        mapViewController.tabBarItem = UITabBarItem(title: "Карта",
                                                    image: UIImage(systemName: "map"),
                                                    selectedImage: UIImage(systemName: "map.fill"))
        self.mapViewController = mapViewController
    }
}

extension MapCoordinator: TabBarCoordinator {
    var rootViewController: UIViewController {
        mapViewController
    }
    
    func start() {
        
    }
}
