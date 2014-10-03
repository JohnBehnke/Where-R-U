//
//  Ride.swift
//  Where R U?
//
//  Created by John Behnke on 9/29/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import Foundation
import MapKit

class Ride{
    
//Variables - Driver (Person), list of participants(Person), list of person needed to be picked up, list of persons currently picked up, dates and times, locations(driver current, destinations - passenger current for pickup or static destination for dropoff)
    
    
    
    
    
    
    init(title: String, driver: Person, startLocation: Double, destinationGPS: Double, destinationName: String  , passengers: [Person] ){ //Initalizer for one-time carpool
        self.title = title
        self.driver = driver
       // self.startLocation = startLocation
        self.passengers = passengers
        self.toPickUp = passengers
        self.startLocation = 0.0
        self.pickedUp = []
        self.destinationGPS = destinationGPS
        self.destinationName = destinationName
        self.waypoints = []
      
    }
    
    
    
    private var title: String
    private var driver: Person
    private var passengers: [Person]
    private var toPickUp : [Person]
    private var pickedUp : [Person]
    private var startLocation: Double
    private var destinationGPS : Double
    private var destinationName: String
    private var waypoints : [Double]
    
    

    func getTitle() ->String{
        return self.title
    }
    
    func setTitle(newTitle: String){
        self.title = newTitle
    }
    
    
    
    
    
    func getDriver() -> Person{
        return self.driver
    }
    
    func setDriver(newDriver: Person){
        self.driver = newDriver
    }
    

    
    
    func getPassengers() ->[Person]{
        return self.passengers
    }
    
    func setPassengers(newPassengerGroup: [Person]){
        
        self.passengers = newPassengerGroup
    }
    
    func addPassenger(newPassenger: Person) -> Bool{
        
        var currentlyPresent:Bool = false
        for (var i = 0; i < self.passengers.count; i++){
            
            if (self.passengers[i] == newPassenger){
                return false
            }
            
        }
        
        if currentlyPresent == false && self.passengers.count <= 8   {
            
            
            self.passengers.append(newPassenger)
            return true
        }
        else{
            
            return false
        }
    }
    
    func removePassenger(toRemove: Person) -> Bool{
        
        for (var i = 0; i < self.passengers.count; i++) {
            
            if self.passengers[i] == toRemove{
                
                var removed = passengers.removeAtIndex(i)
                return true
            }
            
            
            
        }
        return false
        
    }
    
    
    
    
    func getToPickUp() -> [Person]{
        return self.toPickUp
    }
    
    func getPickedUp() -> [Person]{
        return self.pickedUp
    }
    
    func getStartLocation() ->Double{
        return self.startLocation
    }
    
    func getDestinationGPS() -> Double{
        return self.destinationGPS
    }
    
    func getDestinationName() ->String{
        return self.destinationName
    }
    func getWaypoints() ->[Double]{
        return self.waypoints
    }
    
}


