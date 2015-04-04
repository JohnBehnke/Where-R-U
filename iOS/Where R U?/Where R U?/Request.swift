//
//  request.swift
//  Where R U?
//
//  Created by Zachary Minster on 4/3/15.
//  Copyright (c) 2015 John Behnke. All rights reserved.
//

import Foundation

//Class to store friend requests
class Request {
    
    init(name: String) {
        requestSender = name
    }
    
    //variables
    private var requestSender: String
    
    
    //Get and set functions
    func getSender() ->String{
        return requestSender
    }
}