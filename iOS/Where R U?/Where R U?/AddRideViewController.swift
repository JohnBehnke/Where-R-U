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

    //MARK: - Class Variables
    
    var isSingleRide = true
    
    var ridesVC: MyRidesViewController!

    
    //MARK: - IBOutlets
    
    @IBOutlet weak var seatCountLabel: UILabel!
    
    @IBOutlet weak var seatSteper: UIStepper!

  
    @IBOutlet var rideTitle: UITextField!
    
    @IBOutlet weak var rideDescription: UITextField!
    
   
    //MARK: - IBActions
    
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
      @IBAction func seatStepper(sender: UIStepper) {
         seatCountLabel.text = Int(sender.value).description
    }
    
    @IBAction func savePressed(sender: UIBarButtonItem) {
        
        var personObj:Person = Person(firstName: "John", lastName: "Behnke", userName: "Test")
        var ride:Ride = Ride(title: rideTitle.text, description: rideDescription.text, destination: "RCOS", seatsAvailable: Int(seatSteper.value), driver: personObj)
        
        if isSingleRide{
            ridesVC.oneTimeRides.append(ride)
        }
        else{
            
            ridesVC.scheduledRides.append(ride)
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }

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

    
    //MARK: - Default Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Touch Controls
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent){
                self.view.endEditing(true)
    }

}