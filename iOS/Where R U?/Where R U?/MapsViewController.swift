//
//  mapsViewController.swift
//  Where R U?
//
//  Created by John Behnke on 9/8/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import UIKit
import MapKit
import Foundation
import Parse




class MapsViewController: UIViewController, MKMapViewDelegate  {
    
    var locationManager :CLLocationManager! = nil
    var theMapView: MKMapView!
    
    
    
    //This function is only run once when app opens
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //Login Screen stuff
    
    //This function is run every time the view is opened? IDK why
    override func viewDidAppear(animated: Bool) {
        //Create Login
        super.viewDidAppear(animated)
    }
    
    //This is the refresh function for the view I think
    override func viewWillAppear(animated: Bool) {
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            
            
            var me = Person(firstName: "first",lastName: "last",userName: currentUser!)
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
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

