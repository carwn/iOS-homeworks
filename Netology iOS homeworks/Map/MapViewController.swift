//
//  MapViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 28.08.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapService: MapService?
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let randomLocation = MapService.ExampleLocations.allCases.randomElement() {
            addPin(location: randomLocation)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let mapService = mapService {
            mapService.getLocation { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let location):
                    self.mapView.showsUserLocation = true
                    self.mapView.setCenter(location.coordinate, animated: true)
                case.failure(let error):
                    self.showError(error)
                }
            }
        }
    }
    
    private func addPin(location: MapService.ExampleLocations) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = location.title
        mapView.addAnnotation(annotation)
    }
}
