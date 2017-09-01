//
//  ViewController.swift
//  Location&Map
//
//  Created by linsyorozuya on 2017/9/1.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager:CLLocationManager! = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        findButton.layer.cornerRadius = 25
        findButton.layer.borderColor = UIColor.white.cgColor
        findButton.layer.borderWidth = 2
        
        mapView.delegate = self
    }

    @IBAction func findLocation(_ sender: Any) {
        // get adress
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // show userLocation
        // span determine the map's detail infomation
        let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region:MKCoordinateRegion = MKCoordinateRegion.init(center: mapView.userLocation.coordinate, span: span)
        mapView.region = region
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // translate
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placeMarks, error) in
            if placeMarks?.count == 0{
                let placeMark : CLPlacemark = placeMarks![0]
                self.locationLabel.text = placeMark.locality! + " " + placeMark.thoroughfare!
                
            }
        }
    }
}

extension ViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "MyCustomAnnotation")
        if annotationView == nil{
            annotationView = MKAnnotationView.init(annotation: annotation, reuseIdentifier: "MyCustomAnnotation")
            annotationView?.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
            annotationView?.layer.cornerRadius = 10
            annotationView?.backgroundColor = UIColor.blue
            annotationView?.layer.borderColor = UIColor.white.cgColor
            annotationView?.layer.borderWidth = 3
            annotationView?.canShowCallout = true
        }
        let button = UIButton.init(type: .infoDark)
        annotationView?.leftCalloutAccessoryView = button
        return annotationView
        
//        let pinView = MKPinAnnotationView()
//        pinView.pinTintColor = UIColor.red
//        pinView.canShowCallout = true
//        return pinView
    }
}



