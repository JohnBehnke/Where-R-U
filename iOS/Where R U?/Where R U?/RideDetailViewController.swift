//
//  RideDetailViewController.swift
//  Where R U?
//
//  Created by John Behnke on 11/23/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import UIKit
import Parse

class RideDetailViewController: UIViewController {
    
    //MARK: - Class Variables
    
    var detailRide: Ride!
    
    var rideVC: MyRidesViewController!
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var rideName: UITextField!
    
    @IBOutlet weak var rideDriver: UITextField!
    
    @IBOutlet weak var rideDestination: UITextField!
    
    //MARK: - IBActions
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    //MARK: - Default Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rideName.text = detailRide.getTitle()
        self.rideDriver.text = detailRide.getDriver().getFirstName()
        self.rideDestination.text = detailRide.getDestinationName()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
