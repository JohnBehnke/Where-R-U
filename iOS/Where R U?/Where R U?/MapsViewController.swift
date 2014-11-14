//
//  mapsViewController.swift
//  Where R U?
//
//  Created by John Behnke on 9/8/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController, MKMapViewDelegate  {
    
    
    var theMapView :MKMapView! = nil
    var locationManager :CLLocationManager! = nil

    // var theMapView: MKMapView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        var me = Person(firstName: "test", lastName: "test", userName: "test")
                if (CLLocationManager.locationServicesEnabled()){
                
                me.updateLocation()
                
                let location = me.getLocation()
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

