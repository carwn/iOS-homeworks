//
//  Planet.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 03.05.2022.
//

import Foundation

//{
//    "name": "Tatooine",
//    "rotation_period": "23",
//    "orbital_period": "304",
//    "diameter": "10465",
//    "climate": "arid",
//    "gravity": "1 standard",
//    "terrain": "desert",
//    "surface_water": "1",
//    "population": "200000",
//    "residents": [
//        "https://swapi.dev/api/people/1/",
//        "https://swapi.dev/api/people/2/",
//        "https://swapi.dev/api/people/4/",
//        "https://swapi.dev/api/people/6/",
//        "https://swapi.dev/api/people/7/",
//        "https://swapi.dev/api/people/8/",
//        "https://swapi.dev/api/people/9/",
//        "https://swapi.dev/api/people/11/",
//        "https://swapi.dev/api/people/43/",
//        "https://swapi.dev/api/people/62/"
//    ],
//    "films": [
//        "https://swapi.dev/api/films/1/",
//        "https://swapi.dev/api/films/3/",
//        "https://swapi.dev/api/films/4/",
//        "https://swapi.dev/api/films/5/",
//        "https://swapi.dev/api/films/6/"
//    ],
//    "created": "2014-12-09T13:50:49.641000Z",
//    "edited": "2014-12-20T20:58:18.411000Z",
//    "url": "https://swapi.dev/api/planets/1/"
//}

struct Planet: Codable {
    let name, rotationPeriod, orbitalPeriod, diameter, climate, gravity, terrain, surfaceWater, population: String
    let residents, films: [URL]
    let created, edited: Date
    let url: URL

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
    }
    
    static let customJSONDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
