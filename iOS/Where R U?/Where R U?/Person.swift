//
//  Person.swift
//  Where R U?
//
//  Created by John Behnke on 9/29/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import Foundation
import MapKit


//Person class. Needs a firstName, lastName (Strings) and GPS locations (GPS type objects?)
class Person: NSObject, CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager! = nil
    
    init(firstName: String, lastName: String, userName: String){
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.currentLocation = CLLocation()
        super.init()
    }
    
    func updateLocation(){  //activates location updates
        if (CLLocationManager.locationServicesEnabled()){
            //gets gps data
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            let newLocation = locationManager.location
            currentLocation = newLocation
        }
    }
    
    //CLLocationManager Delegate
    
    //If Location was successfully updated, this function is run
    //THIS FUNCTION IS NOT BEING CALLED  PROBLEM WITH DELEGATE
    func locationManager(manager: CLLocationManager!, didUpdateLocations location:[AnyObject]) {
        let location = locationManager.location
        self.currentLocation = location
    }
    
    //End Delegate
    
    func getLocation() ->CLLocation {
        return currentLocation
    }
    
    func getFirstName() ->String{
        return firstName
    }
    
    func getLastName() ->String{
        return lastName
    }
    
    //For user security, may want only user name to be displayed
    func getUserName() ->String {
        return userName
    }
    

    
    private var firstName : String
    private var lastName : String
    private var userName : String
    private var currentLocation : CLLocation
    //current location variable either as a CLLocationManager.location object or float coversion of lat/long
  
}


