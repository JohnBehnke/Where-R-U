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
        self.startLocation = startLocation
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
    
}

