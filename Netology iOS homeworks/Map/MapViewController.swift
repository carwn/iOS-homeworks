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
            mapView.showsScale = true
            mapView.mapType = .hybrid
            let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(getCoordinatePressOnMap(sender:)))
            mapView.addGestureRecognizer(gestureRecognizer)
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
                        self.replaceRoute(route)
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
        addPin(coordinate: location.coordinate, title: location.title)
    }
    
    private func addPin(coordinate: CLLocationCoordinate2D, title: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
    
    private func replaceRoute(_ route: MKRoute) {
        removeRoutes()
        addRoute(route)
    }
    
    private func addRoute(_ route: MKRoute) {
        mapView.addOverlay(route.polyline)
        mapView.setVisibleMapRect(route.polyline.boundingMapRect,
                                  edgePadding: UIEdgeInsets(top: Constants.padding,
                                                            left: Constants.padding,
                                                            bottom: Constants.padding,
                                                            right: Constants.padding),
                                  animated: true)
    }
    
    private func removeRoutes() {
        mapView.removeOverlays(mapView.overlays.compactMap({ $0 as? MKPolyline }))
    }
    
    @objc
    private func getCoordinatePressOnMap(sender: UITapGestureRecognizer) {
        if sender.state == .began {
            let touchLocation = sender.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            addPin(coordinate: locationCoordinate, title: "user pin")
        }
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

extension MapViewController {
    enum Constants {
        static let padding: CGFloat = 40
    }
}
