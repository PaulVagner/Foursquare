//
//  FirstViewController.swift
//  NearMe

//  Created by Paul Vagner on 10/5/15.
//  Copyright © 2015 Paul Vagner. All rights reserved.
//

import UIKit
//imports the information from the MapKit files
import MapKit

class FirstViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    //creates a map view
    @IBOutlet weak var myMapView: MKMapView!
                        // find location/region/etc (manages all location information)
    let locManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myMapView.delegate = self
        
        //need to ask for location from the unit (Phone)
     locManager.requestWhenInUseAuthorization()
      //location manager can call methods on the view controller (specifically - locationManager)
     locManager.delegate = self
        
        //asks for location to mark on map
        myMapView.showsUserLocation = true
        
        //shows the blue dot on map - doew not work - FIX ME
       myMapView.mapType = .Hybrid
        
        //requests to update location several times (continued - nonstop)
        locManager.startUpdatingLocation()
        
        
        //ask the divice what the current location is.
        locManager.requestLocation()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    // Dispose of any resources that can be recreated.
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        for location in locations {
            
            print(location.coordinate.latitude, location.coordinate.longitude)
            
            //sets up the annotation
            let annotation = MKPointAnnotation()
            
            
            annotation.coordinate = location.coordinate
            annotation.title = "This Is Cool"
            annotation.subtitle = "And Fun!!!"
            
            myMapView.addAnnotation(annotation)
            
            
        }
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        
        print(error)
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        //creates the pin on the map
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        
       // annotationView.pinColor = .Purple
       //adjusts the pin color to a specific value
        annotationView.pinTintColor = UIColor(red:0.22, green:1, blue:0.08, alpha:1)
        
        
        // if you override the annotationView, this line is needed to call out the annotationView
        annotationView.canShowCallout = true
        
        let button = UIButton(type: .DetailDisclosure)
        
        button.addTarget(self, action: "showDetail:", forControlEvents: .TouchUpInside)
        
        annotationView.rightCalloutAccessoryView = button
        
        
        return annotationView
        
    }

    func showDetail(button: UIButton) {
        //creates a new viewController
        
        if let viewConroller = storyboard?.instantiateViewControllerWithIdentifier("DetailVC") {
        
        //sets background color of the viewController
        viewConroller.view.backgroundColor = UIColor.lightGrayColor()
        
        //tells the navigation controller to PUSH the new viewController.
        navigationController?.pushViewController(viewConroller, animated: true)
        
        
        }
        
    }
    
}

