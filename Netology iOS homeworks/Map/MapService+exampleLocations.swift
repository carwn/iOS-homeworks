//
//  MapService+exampleLocations.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 28.08.2022.
//

import Foundation
import CoreLocation

extension MapService {
    
    enum ExampleLocations: CaseIterable {
        
        case moscow, london, newYork
        
        var coordinate: CLLocationCoordinate2D {
            switch self {
            case .moscow:
                return CLLocationCoordinate2D(latitude: 55.7522, longitude: 37.6156)
            case .london:
                return CLLocationCoordinate2D(latitude: 51.5085, longitude: -0.12574)
            case .newYork:
                return CLLocationCoordinate2D(latitude: 37.6156, longitude: -74.006)
            }
        }
        
        var title: String {
            switch self {
            case .moscow:
                return "moscow".localized
            case .london:
                return "london".localized
            case .newYork:
                return "newYork".localized
            }
        }
    }
}
