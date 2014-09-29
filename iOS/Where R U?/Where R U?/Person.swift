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
    

    
    init(firstName: String, lastName: String){
    
        self.firstName = firstName
        self.lastName = lastName
        
        
    }
    
    
    func getFirstName() ->String{
        
        return firstName
        
    }
    func getLastName() ->String{
        
        return lastName
    }
    
    
    
    private var firstName : String
    private var lastName : String
  
}