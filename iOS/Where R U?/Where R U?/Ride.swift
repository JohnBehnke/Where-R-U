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

    init(title: String,description: String ,destination: String ,seatsAvailable: Int,driver: Person){
        self.title = title
        self.description = description
        self.driver = driver
        self.destinationName = destination
        self.seatsAvailiable = seatsAvailable
        self.passengers = []
        self.toPickUp = self.passengers
        self.pickedUp  = []
        self.isOwner = false
        
    }
    
    private var title: String
    private var description: String
    private var driver: Person
    private var passengers: [Person]
    private var seatsAvailiable: Int
    private var toPickUp : [Person]
    private var pickedUp : [Person]
    private var isOwner : Bool;
    
    //private var startLocation: Double
    //private var destinationGPS : Double
    private var destinationName: String
    // private var waypoints : [Double]
    
    //Returns the title for the ride
    func getTitle() ->String{
        return self.title
    }
    //Sets the title for the ride
    func setTitle(newTitle: String){
        self.title = newTitle
    }
    
    
    //Returns the driver for the ride
    func getDriver() -> Person{
        return self.driver
    }
    
    //Sets the driver for the ride
    func setDriver(newDriver: Person){
        self.driver = newDriver
    }
    

    func setOwner(){
        isOwner = true
    }
    //Returns the current passenger array
    func getPassengers() ->[Person]{
        return self.passengers
    }
    
    func setSeatsAvailable(amountAvailable: Int){
        self.seatsAvailiable = amountAvailable
    }
    
    func getSeatsAvailable() -> Int{
        return self.seatsAvailiable
    }
    
    func incrementSeatsAvailable(){
        self.seatsAvailiable++
    }
    func decrementSeatsAvailable(){
        self.seatsAvailiable--
    }
    
    //Sets the passenger array equal to an array of person objects. Useful if an array of passengers is not specified at the creation of a ride
    func setPassengers(newPassengerGroup: [Person]){
        
        self.passengers = newPassengerGroup
    }
    
    
    
    //Test to see of a person is a passenger of the ride. Trying to stop bad things from happening if they look for a person that is not there
    func verifyIsPassenger(verifyPassenger: Person, passengerArray: [Person])->Bool{
        
        
        for (var i = 0; i < passengerArray.count; i++){
            
            if (passengerArray[i] == verifyPassenger){
                
                return true
                
            }
        }
        
        return false
    }
    
    
    //Add a new passenger to the passenger arrar.
    func addPassenger(newPassenger: Person) -> Bool{
        
        var currentlyPresent = verifyIsPassenger(newPassenger, passengerArray: self.passengers)
        
        if !currentlyPresent && self.passengers.count <= 8 { //Must be equal to or less that 8 b/c of Google Map routing limitations
            
            self.passengers.append(newPassenger)
            
            return true
        }
            
        else{
            
            return false
        }
    }
    
    
    
    //Remove a passenger from the passenger array
    func removePassenger(toRemove: Person) -> Bool{
        
        var currentlyPresent = verifyIsPassenger(toRemove, passengerArray: self.passengers)
        
        if (currentlyPresent){
            
            for (var i = 0; i < self.passengers.count; i++) {
            
                if self.passengers[i] == toRemove{
                
                    var removed = passengers.removeAtIndex(i)
                
                    return true
                
                }
            
            }
            
        }

        return false
        
    }
    
    
    //Return the array of people who need to be picked up
    func getToPickUp() -> [Person]{
        
        return self.toPickUp
    }
    
    
    //Set the array of people who need to be picked up if it
    func setToPickUp(newPickUps: [Person]){
        
        self.toPickUp = newPickUps
    }
    
    
    func addNewPickUp(newPerson: Person) -> Bool{
        
        var currentlyPresent = verifyIsPassenger(newPerson, passengerArray: self.toPickUp)
        
        if !currentlyPresent{
            
            self.toPickUp.append(newPerson)
            return true
        }
        
        
        return false
        
    }


    func removeToPickUp(removePerson: Person) -> Bool{
            
        var currentlyPresent = verifyIsPassenger(removePerson, passengerArray: self.toPickUp)
        
        if (currentlyPresent){
            
            for (var i = 0; i < self.toPickUp.count; i++) {
                    
                if self.toPickUp[i] == removePerson{
                        
                    var removed = toPickUp.removeAtIndex(i)
                        
                    return true
                }

            }
    
        }
        
        return false
    }
        
    func getPickedUpArray() -> [Person]{
        return self.pickedUp
    }
    
    
    // Pick up a person. Check to make sure that they are a passenger, and that the havent been picked up, and that they need to be picked up
    func addPickedUp(gotPickedUp: Person) -> Bool{
        
        
        var inToPickUp = verifyIsPassenger(gotPickedUp, passengerArray: self.toPickUp)
        var inPickedUp = verifyIsPassenger(gotPickedUp, passengerArray: self.pickedUp)
        var inPassenger = verifyIsPassenger(gotPickedUp, passengerArray: self.passengers)
        
        if (inToPickUp && !inPickedUp && inPassenger) {
            
            for (var i = 0; i < self.toPickUp.count; i++){
                
                if (self.toPickUp[i] == gotPickedUp){
                    
                    self.pickedUp.append(self.toPickUp.removeAtIndex(i))
                    
                    return true
                }
            }
        }
        
        return false
    }
    
    
    
    
    
    ////UNCOMMENT WHEN ZACH DOES THE GPS SWAG
    
    
//    func getStartLocation() ->Double{
//        return self.startLocation
//    }
//    
//    func getDestinationGPS() -> Double{
//        return self.destinationGPS
//    }
//    
    func getDestinationName() ->String{
        return self.destinationName
    }
//    func getWaypoints() ->[Double]{
//        return self.waypoints
//    }
    
    

}

