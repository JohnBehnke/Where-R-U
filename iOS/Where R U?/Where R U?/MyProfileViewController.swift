//
//  MyProfileViewController.swift
//  Where R U?
//
//  Created by John Behnke on 5/6/15.
//  Copyright (c) 2015 John Behnke. All rights reserved.
//

import UIKit
import Parse

class MyProfileViewController: UIViewController,PFLogInViewControllerDelegate {
    
    @IBOutlet weak var userNameText: UITextField!
    
    @IBAction func showFriendRequests(sender: AnyObject) {
        
        self.performSegueWithIdentifier("showFriendRequests", sender: self)
    }
    
    @IBAction func zachCantPArselolo(sender: UIButton) {
        
        var username2:String = userNameText.text //This user name can be changed
        
        var friendship = PFObject(className: "Friends")
        var findUser:PFQuery = PFUser.query()!
        
        findUser.whereKey("username",equalTo:username2) //program crashes here for some reason
        
      
        
        findUser.getFirstObjectInBackgroundWithBlock {(user2, error: NSError?) -> Void in
            if user2 == nil {
                println("Failure")
            } else {
                println("Successfully retrieved the object.")
                friendship["user1"] = PFUser.currentUser()!.objectId
                friendship["user2"] = user2!.objectId
                friendship["pending"] = true
                friendship.saveInBackgroundWithBlock {
                    (success:Bool, error:NSError?) -> Void in
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showFriendRequests" {
            
            let showFriendRequestVC:FriendRequestViewController = segue.destinationViewController as! FriendRequestViewController
            showFriendRequestVC.profileVC = self
            
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
