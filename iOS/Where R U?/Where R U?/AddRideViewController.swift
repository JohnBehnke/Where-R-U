//
//  AddRideViewController.swift
//  Where R U?
//
//  Created by John Behnke on 11/11/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//


import UIKit

class AddRideViewController: UIViewController, UITextFieldDelegate {
    
    var ridesVC: MyRidesViewController!
   
    var isSingleRide:Bool = true
    
    @IBOutlet var txtName: UITextField!
    
    @IBOutlet var txtDriver: UITextField!
    
    @IBOutlet var txtDestination: UITextField!

    @IBAction func rideSelector(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            isSingleRide = true
        case 1:
            isSingleRide = false
        default:
            break; 
        }
        
    }
     @IBAction func donePressed(sender: UIButton){
        
        var personObj:Person = Person(firstName: txtDriver.text, lastName: txtDriver.text, userName: "Test")
        
        
        if isSingleRide{
            var ride = Ride(title: txtName.text,destination: txtDestination.text ,driver: personObj)
            ride.setOwner()
        
            ridesVC.oneTimeRides.append(ride)

        }
        
        else{
            var ride = Ride(title: txtName.text,destination: txtDestination.text ,driver: personObj)
             ride.setOwner()
            ridesVC.scheduledRides.append(ride)
           
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
       
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent){
        self.view.endEditing(true)
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

}
