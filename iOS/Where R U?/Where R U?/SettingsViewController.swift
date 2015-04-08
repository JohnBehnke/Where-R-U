//
//  SettingsViewController.swift
//  Where R U?
//
//  Created by John Behnke on 9/8/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,PFLogInViewControllerDelegate {
    
    
    @IBOutlet weak var userNameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    
    @IBAction func zachCantPArselolo(sender: UIButton) {
        
        var username2:String = userNameText.text //This user name can be changed
        
        var friendship = PFObject(className: "Friends")
        var findUser:PFQuery = PFUser.query()
        
        findUser.whereKey("username",equalTo:username2) //program crashes here for some reason
        
        findUser.getFirstObjectInBackgroundWithBlock {
            
            (user2, error: NSError!) -> Void in
            if user2 == nil {
                println("Failure")
            } else {
                println("Successfully retrieved the object.")
                friendship["user1"] = PFUser.currentUser().objectId
                friendship["user2"] = user2.objectId
                friendship["pending"] = true
                friendship.saveInBackgroundWithBlock {
                    (success:Bool, error:NSError!) -> Void in
                    if (success) {
                        println("Friendship saved")
                    }
                }
            }
        }
        
    }
    
    @IBAction func logoutRequest(sender: UIButton) {
        PFUser.logOut()
        var currentUser = PFUser.currentUser() // this will now be nil
        tabBarController?.selectedIndex = 0
        
        
    }
    
    //Prepares to transition to another view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showFriendRequests" {
            
            let showFriendRequestVC:FriendRequestViewController = segue.destinationViewController as FriendRequestViewController
            showFriendRequestVC.settingsVC = self
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}

