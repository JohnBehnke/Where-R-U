//
//  AddRideViewController.swift
//  Where R U?
//
//  Created by John Behnke on 2/15/15.
//  Copyright (c) 2015 John Behnke. All rights reserved.
//

import Foundation
import UIKit

class AddRideViewController: UITableViewController ,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {

    
    @IBOutlet weak var seatCountLabel: UILabel!
    var isSingleRide = true
    
    var ridesVC: MyRidesViewController!

    @IBOutlet weak var seatSteper: UIStepper!

    
    @IBAction func seatStepper(sender: UIStepper) {
         seatCountLabel.text = Int(sender.value).description
        
    }
    @IBOutlet var txtName: UITextField!
    
    @IBAction func rideTypeToggle(sender: UISegmentedControl) {
        
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
    @IBOutlet weak var rideDescription: UITextField!
   
    @IBAction func savePressed(sender: UIBarButtonItem) {
        
        var personObj:Person = Person(firstName: "John", lastName: "Behnke", userName: "Test")
        var ride:Ride = Ride(title: txtName.text, description: rideDescription.text, destination: "RCOS", driver: personObj)
        
        if isSingleRide{
            ridesVC.oneTimeRides.append(ride)        }
        else{
            
            ridesVC.scheduledRides.append(ride)
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
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

}