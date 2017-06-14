//
//  ViewController.swift
//  MapDragSample
//
//  Created by Jamel Robinson on 6/13/17.
//  Copyright © 2017 Jamel Robinson. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
   
    let locationManager = CLLocationManager()
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        if let location = locations.first {
            
            let cl: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            setUpMapWithLocation(location: cl)
            locationManager.stopUpdatingLocation()
            
        }
    }
    
    var alreadyGotLocation = false
    
    func setUpMapWithLocation(location:CLLocationCoordinate2D){
    
        if(alreadyGotLocation == false){
            
        let span = MKCoordinateSpanMake(0.003, 0.003)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        //add your draggable annotation
        
        let annotation = DragMarker(coordinate: location)
            mapView.addAnnotation(annotation)
            
        alreadyGotLocation = true
            
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // set the map type
        mapView.mapType = MKMapType.standard
        mapView.delegate = self
        
        
        //set a location with location manager
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
     
        
  
        
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var pin: MKPinAnnotationView? = (mapView.dequeueReusableAnnotationView(withIdentifier: "myMarker") as? MKPinAnnotationView)
        if pin == nil {
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myMarker")
           
        }
        else {
            pin?.annotation = annotation
        }
        pin?.animatesDrop = true
        pin?.isDraggable = true
        return pin!
    }
    
   func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
    
    let message: String = "Your new coordinates are \(String(describing: view.annotation!.coordinate))"
    
    let alert = UIAlertController(title: "Pin Moved!", message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

