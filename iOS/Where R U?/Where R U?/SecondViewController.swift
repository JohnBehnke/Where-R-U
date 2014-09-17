//
//  SecondViewController.swift
//  Where R U?
//
//  Created by John Behnke on 9/8/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate  {
    
    var theMapView :MKMapView! = nil
    var locationManager :CLLocationManager! = nil
    
    @IBAction func myRides(sender:UISwipeGestureRecognizer) {
       
       tabBarController?.selectedIndex = 1
    }
    

    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (CLLocationManager.locationServicesEnabled()){

            
            //the following code gets GPS data and places it on the map. Its just temp code to show it working. It should be put in its own .swift class or something. <- Needs to happen
            
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            
            //Will now begin tracking the user.  Will go to one of the 2 functions below (fail/success)
        }
    }
    
    //If at any time Location update does not work, display error message.  For debugging purposes only
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error while updating location")
    }
    
    //If Location was successfully updated, this function is run
    func locationManager(manager: CLLocationManager!, didUpdateLocations location:[AnyObject]) {
        //println("Success")
        
        let location = locationManager.location
        var latDelta:CLLocationDegrees = 0.01
        var longDelta:CLLocationDegrees = 0.01
        var Span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude , longitude: location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(center, Span)
        
        self.theMapView.setCenterCoordinate(center, animated: true)
        self.theMapView.setRegion(region, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

