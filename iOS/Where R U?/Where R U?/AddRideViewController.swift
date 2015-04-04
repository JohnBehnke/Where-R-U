//
//  AddRideViewController.swift
//  Where R U?
//
//  Created by John Behnke on 2/15/15.
//  Copyright (c) 2015 John Behnke. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AddRideViewController: UITableViewController ,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {

    //MARK: - Class Variables
    
    var isSingleRide = true
    
    var ridesVC: MyRidesViewController!
    
    var destination: MKMapItem!
    
     var datePickerHidden = false

    
    //MARK: - IBOutlets
    
    @IBOutlet weak var seatCountLabel: UILabel!
    
    @IBOutlet weak var seatSteper: UIStepper!

    @IBOutlet weak var rideTitle: UITextField!
    
    @IBOutlet weak var rideDescription: UITextField!
    
    @IBOutlet weak var rideDestination: UITextField!
    
    @IBOutlet weak var dateLabel: UILabel!
   
    @IBOutlet weak var datePicker: UIDatePicker!
    //MARK: - IBActions
    
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func seatStepper(sender: UIStepper) {
         seatCountLabel.text = Int(sender.value).description
    }
    
    @IBAction func savePressed(sender: UIBarButtonItem) {
        
        var personObj:Person = Person(firstName: "John", lastName: "Behnke", userName: "Test")
        var ride:Ride = Ride(title: rideTitle.text, description: self.rideDescription.text, destination: self.destination.name, seatsAvailable: Int(self.seatSteper.value), driver: personObj)
        
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
    
    
    @IBAction func didChangeDate(sender: UIDatePicker) {
        
        dateLabel.text = NSDateFormatter.localizedStringFromDate(datePicker.date, dateStyle: .ShortStyle, timeStyle: .ShortStyle)

    }
 

    //MARK: - Segue Preperation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "showDestination"{
            let destinationVC: DestinationSearchViewController = segue.destinationViewController as DestinationSearchViewController
            destinationVC.addRideVC = self
 
        }
        
    
    
    }
    
     override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (2, 0):
            toggleDatePicker()
        default:
            ()
        }
    }
    
     override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if datePickerHidden && indexPath.section == 2 && indexPath.row == 1 {
            return 0.0
        } else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    func toggleDatePicker() {
        datePickerHidden = !datePickerHidden
        
        // Force table to update its contents
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    //MARK: - Default Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        didChangeDate(self.datePicker)
        toggleDatePicker()
      
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