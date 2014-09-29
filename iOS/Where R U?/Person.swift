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
class Person{
    

    var locationManager :CLLocationManager! = nil
    
    init(firstName: String, lastName: String, userName: String){
    
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.currentLocation = CLLocation()
        self.currentLocation = updateLocation()
    }
    
    func updateLocation() -> CLLocation{  //activates location updates
        
        if (CLLocationManager.locationServicesEnabled()){
            //the following code gets GPS data and places it on the map. Its just temp code to show it working. It should be put in its own .swift class or something. <- Needs to happen

            locationManager = CLLocationManager()
            
            //locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            //return locationManager.location
            
            //Will now begin tracking the user.  Will go to one of the 2 functions below (fail/success)
        }
        return CLLocation()
    }
    
    //If at any time Location update does not work, display error message.  For debugging purposes only
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error while updating location")
    }
    
    //If Location was successfully updated, this function is run
    func locationManager(manager: CLLocationManager!, didUpdateLocations location:[AnyObject]) ->CLLocation{
        let location = locationManager.location
        return location
    }
    
    func newLocation(newL : CLLocation) {
        currentLocation = newL
    }
    
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



