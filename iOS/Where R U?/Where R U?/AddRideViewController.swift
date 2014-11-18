//
//  AddRideViewController.swift
//  Where R U?
//
//  Created by John Behnke on 11/11/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//


import UIKit

class AddRideViewController: UIViewController, UITextFieldDelegate {
    
    var isSingleRide:Bool = true
    
    @IBOutlet var txtName: UITextField!
    
    @IBOutlet var txtDriver: UITextField!
    

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donePressed(sender: UIButton){
        
        var personObj:Person = Person(firstName: txtDriver.text, lastName: txtDriver.text, userName: "Test")
        
        
        if isSingleRide{
        
            
            rideManager.addOneTimeRide(txtName.text, driver: personObj)
            self.view.endEditing(true)
            txtDriver.text = ""
            txtName.text = ""
        }
        
        else{
            
            rideManager.addScheduledRides(txtName.text, driver: personObj)
            self.view.endEditing(true)
            txtDriver.text = ""
            txtName.text = ""
            
        }
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent){
        self.view.endEditing(true)
    }
    
    

    func  textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
}
