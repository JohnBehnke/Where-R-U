//
//  SecondViewController.swift
//  Where R U?
//
//  Created by John Behnke on 9/8/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import UIKit
import MapKit



class SecondViewController: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet var theMapView :MKMapView
   
    override func viewDidLoad() {
        super.viewDidLoad()
       if (CLLocationManager.locationServicesEnabled()){
        
        //the following code gets GPS data and places it on the map. Its just temp code to show it working. It should be put in its own .swift class or something. 
            var locationManager = CLLocationManager()
            locationManager = CLLocationManager()
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        
            let location = locationManager.location
            var latDelta:CLLocationDegrees = 0.01
            var longDelta:CLLocationDegrees = 0.01
            var Span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude , longitude: location.coordinate.longitude)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(center, Span)
      
            self.theMapView.setCenterCoordinate(center, animated: true)
            self.theMapView.setRegion(region, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}