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


struct ride {
    var name = "Name"
    var driver = "Driver"
    //var time = "ETA XX"
    
}

class RideManager: NSObject{
    
    var rides = [ride]()
    
    func addRide(name: String, driver: String){
        rides.append(ride(name: name, driver: driver))
        
    }
}