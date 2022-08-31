//
//  MapService.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 28.08.2022.
//

import Foundation
import CoreLocation
import MapKit

typealias GetLocationCompletion = (Result<CLLocation, MapServiceError>) -> Void

class MapService: NSObject {
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    private var storedCompletion: GetLocationCompletion?
    
    func getLocation(_ completion: @escaping GetLocationCompletion) {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            storedCompletion = completion
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = locationManager.location {
                completion(.success(location))
            } else {
                storedCompletion = completion
                locationManager.startUpdatingLocation()
            }
        case .denied, .restricted:
            completion(.failure(.locationAccessDenied))
        @unknown default:
            fatalError()
        }
    }
    
    func getRoute(to destination: CLLocationCoordinate2D, completion: @escaping (Result<MKRoute, MapServiceError>) -> Void) {
        getLocation { result in
            switch result {
            case .success(let source):
                let request = MKDirections.Request()
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: source.coordinate))
                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
                let directions = MKDirections(request: request)
                directions.calculate { responce, error in
                    if let route = responce?.routes.first {
                        completion(.success(route))
                    } else if let error = error {
                        completion(.failure(.other(error)))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension MapService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if let storedCompletion = storedCompletion {
            getLocation(storedCompletion)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if let storedCompletion = storedCompletion {
                storedCompletion(.success(location))
                self.storedCompletion = nil
            }
            locationManager.stopUpdatingLocation()
        }
    }
}
