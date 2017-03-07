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
            mapView.delegate = nil
            mapView.delegate = self
        }
    }
    let regionRadius : CLLocationDistance = 50
    
    var locationManager = CLLocationManager(){
        didSet{
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
    }
    
    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initalLocation = CLLocation(latitude: 48.89650732, longitude: 2.31852293)
        mapView.addAnnotation(Place(Title: "42", SubTitle: "ecole cool", coordinate: CLLocationCoordinate2D(latitude: initalLocation.coordinate.latitude, longitude: initalLocation.coordinate.longitude)))
        centerMapOnLocation(location: initalLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension FirstViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Place {
            let identifier = "pin"
            var view:MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            }
            else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure)
            }
            return view
        }
        return nil
    }
    
    func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
        print(mapView)
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        for elem in views {
            print(elem)
        }
    }
}

extension FirstViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for elem in locations {
            print(elem)
        }
    }
}

