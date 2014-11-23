//
//  RideManager.swift
//  Where R U?
//
//  Created by John Behnke on 11/11/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import Foundation
import UIKit


var rideManager: RideManager = RideManager()



class RideManager: NSObject{
    
    var oneTimeRides = [Ride]()
    
    var scheduledRides = [Ride]()
    
    
    
    func addOneTimeRide(name: String, driver: Person){
        oneTimeRides.append(Ride(title: name, driver: driver))
    }
    
    func addScheduledRides(name: String, driver: Person){
        scheduledRides.append(Ride(title: name, driver: driver))
        
    }

    
}