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
class Person: NSObject {
    
    var locationManager : CLLocationManager! = nil
    
    init(firstName: String, lastName: String, userName: String){
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.currentLocation = CLLocation()
        super.init()
    }
    
//    override init() {
//        self.firstName = ""
//        self.lastName = ""
//        self.userName = ""
//        self.currentLocation = CLLocation()
//        super.init()
//    }
    
    func updateLocation(){  //activates location updates
        if (CLLocationManager.locationServicesEnabled()){
            //gets gps data
            locationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            let newLocation = locationManager.location
            if (newLocation != nil) {
                println("Location Updated")
                self.setLocation(newLocation)       //<- Problem Child for simulating
                locationManager.stopUpdatingLocation()
            }
            else {
                println("Location was nil")
            }
        }
    }
    
    func setLocation(location: CLLocation) {
        self.currentLocation = location
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
    
    func getPersonByUserName(uName: String) -> Person {
        return self
    }
    

    
    private var firstName : String
    private var lastName : String
    private var userName : String
    private var currentLocation : CLLocation
    //current location variable either as a CLLocationManager.location object or float coversion of lat/long
  
}


