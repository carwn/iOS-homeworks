//
//  AppConfiguration.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 23.04.2022.
//

import Foundation

enum AppConfiguration: CaseIterable {
    
    case people, starships, planets
    
    var url: URL {
        switch self {
        case .people:
            return URL(string: "https://swapi.dev/api/people/8")!
        case .starships:
            return URL(string: "https://swapi.dev/api/starships/3")!
        case .planets:
            return URL(string: "https://swapi.dev/api/planets/5")!
        }
    }
}
