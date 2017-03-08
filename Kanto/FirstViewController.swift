//
//  FirstViewController.swift
//  Kanto
//
//  Created by luc Casimir on 07/03/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController {

    @IBOutlet weak var segmentedBar: UISegmentedControl!
    
    @IBOutlet weak var mapView: MKMapView!{
        didSet{
            mapView.delegate = self
        }
    }
    
    private let regionRadius : CLLocationDistance = 1000
    
    fileprivate var locationManager = CLLocationManager()
    
    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    fileprivate let places = PlacesManager()
    
    private func addNotation()
    {
        let data = places.getData
        for elem in data {
            mapView.addAnnotation(elem)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 100
        addNotation()
        let ecole = places.first
        centerMapOnLocation(location: ecole.location)
    }

    @IBAction func switchMap(_ sender: UISegmentedControl) {
        let identifier = sender.selectedSegmentIndex
        switch identifier {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .satellite
        }
    }
    @IBAction func centerLocalisation(_ sender: UIButton)
    {
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

}

extension FirstViewController : MKMapViewDelegate{
    
    private func setPinTinColor(Pin pin: MKPinAnnotationView, Type typ:Type)
    {
        switch typ {
        case .monument:
            pin.pinTintColor = UIColor.blue
        default:
            pin.pinTintColor = UIColor.red
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Place {
            let identifier = "pin"
            var view:MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
                setPinTinColor(Pin: view, Type: annotation.type)
            }
            else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure)
                setPinTinColor(Pin: view, Type: annotation.type)
            }
            return view
        }
        return nil
    }
}

extension FirstViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.showsUserLocation = true
        locationManager.stopUpdatingLocation()
        if let userLocalisation = locations.first {
            centerMapOnLocation(location: userLocalisation)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("erreur de localisation!")
    }
}

