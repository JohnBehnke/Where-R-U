//
//  SettingsViewController.swift
//  Where R U?
//
//  Created by John Behnke on 9/8/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,PFLogInViewControllerDelegate {
    
    
    
    
    //MARK: - IBActions
    @IBAction func zachCantPArselolo(sender: UIButton) {
        
        var friendship = PFObject(className: "Friends")
        var query = PFUser.query()
        query.whereKey("username", equalTo:"butts") //program crashes here for some reason
        query.getFirstObjectInBackgroundWithBlock {
            (user2, error: NSError!) -> Void in
            if user2 != nil {
                NSLog("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                NSLog("Successfully retrieved the object.")
                friendship["user1"] = PFUser.currentUser().objectId
                friendship["user2"] = user2.objectId
                friendship.save()
            }
        }

    }

    
    @IBAction func logoutRequest(sender: UIButton) {
        
        
        PFUser.logOut()
       // var currentUser = PFUser.currentUser() // this will now be nil
        
        tabBarController?.selectedIndex = 0
        
        
    }
    
    //MARK: - Default Functions
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

