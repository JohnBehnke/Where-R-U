//
//  SettingsViewController.swift
//  Where R U?
//
//  Created by John Behnke on 9/8/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UIViewController,PFLogInViewControllerDelegate {
    
    
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    
    
    
    @IBAction func logoutRequest(sender: UIButton) {
        PFUser.logOut()
        var currentUser = PFUser.currentUser() // this will now be nil
        tabBarController?.selectedIndex = 0
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}







