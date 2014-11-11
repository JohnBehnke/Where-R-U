//
//  AddRideViewController.swift
//  Where R U?
//
//  Created by John Behnke on 11/11/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//


import UIKit

class AddRideViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var txtName: UITextField!
    
    @IBOutlet var txtDriver: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donePressed(sender: UIButton){
        self.view.endEditing(true)
        txtDriver.text = ""
        txtName.text = ""
        
        rideManager.addRide(txtName.text, driver: txtDriver.text)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent){
        self.view.endEditing(true)
    }
    
    

    func  textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
}
