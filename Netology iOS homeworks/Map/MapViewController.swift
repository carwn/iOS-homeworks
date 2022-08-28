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
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    
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
    
    @IBAction func routeButtonPressed() {
        let destinations = MapService.ExampleLocations.allCases
        guard !destinations.isEmpty else {
            return
        }
        let sheet = UIAlertController(title: "Выберете назначение", message: nil, preferredStyle: .actionSheet)
        for destination in destinations {
            sheet.addAction(UIAlertAction(title: destination.title, style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.mapService?.getRoute(to: destination.coordinate) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let route):
                        self.addRoute(route)
                    case .failure(let error):
                        self.showError(error)
                    }
                }
            }))
        }
        sheet.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(sheet, animated: true)
    }
    
    private func addPin(location: MapService.ExampleLocations) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = location.title
        mapView.addAnnotation(annotation)
    }
    
    private func addRoute(_ route: MKRoute) {
        mapView.addOverlay(route.polyline)
        mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
        renderer.lineWidth = 3
        return renderer
    }
}
