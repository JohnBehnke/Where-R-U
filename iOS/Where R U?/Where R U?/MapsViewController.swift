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
    
    //@IBOutlet weak var dsdad: MKMapView!
    //var theMapView :MKMapView! = nil
    var locationManager :CLLocationManager! = nil

     var theMapView: MKMapView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var testObject = PFObject(className:"TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackground()
        
        var me = Person(firstName: "first",lastName: "last",userName: "user")
    
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
    



    //If at any time Location update does not work, display error message.  For debugging purposes only
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error while updating location")
    }
    
    //If Location was successfully updated, this function is run
    func locationManager(manager: CLLocationManager!, didUpdateLocations location:[AnyObject]) {
        //println("Success")
        
        let location = locationManager.location
        var test: Double  = location.coordinate.latitude
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

