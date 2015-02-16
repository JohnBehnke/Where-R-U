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

    var ridesVC: MyRidesViewController!

    @IBOutlet var txtName: UITextField!
    
    //@IBOutlet var txtName: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func savePressed(sender: UIBarButtonItem) {
        println(txtName.text)
        
        var personObj:Person = Person(firstName: "John", lastName: "Behnke", userName: "Test")
        var ride = Ride(title: txtName.text ,destination: "RCOS" ,driver: personObj)
        ridesVC.oneTimeRides.append(ride)
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
       self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent){
        self.view.endEditing(true)
    }




}