//
//  FriendRequestController.swift
//  Where R U?
//
//  Created by Zachary Minster on 2/24/15.
//  Copyright (c) 2015 John Behnke. All rights reserved.
//

import Foundation


class FriendRequestViewController: UITableViewController,UITableViewDelegate, UITableViewDataSource{

    var settingsVC: SettingsViewController!
    
    internal var friendRequests:[Request] = []
    
    @IBOutlet var requestTable: UITableView!

    func Query() {
        //query database for friend request to current user
        var loadRequests:[Request] = []
        var friendshipQuery = PFQuery(className: "Friends")
        friendshipQuery.whereKey("user2", equalTo: PFUser.currentUser().objectId)
        friendshipQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            //because we dont like errors
            if (error == nil) {
                println("retrieved \(objects.count) requests")
                
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        //get userId of sender
                        var userID = object.objectForKey("user1") as String

                        //query the user table for the name matching that userId
                        var findUser:PFQuery = PFUser.query();
                        findUser.whereKey("objectId",  equalTo: userID)
                        //QUERYSEPTION
                        findUser.getFirstObjectInBackgroundWithBlock {
                            (user, error2: NSError!) -> Void in
                            if (error2 == nil) {
                                var username = user.objectForKey("username") as String
        
                                //SWIFT PLS STAHP Q.Q
                                println(username)
                                //usernmae is retrieved succesfully, but the new request is not being appended to array
                                //Create a new request with the received name
                                var newRequest:Request = Request(name: username)
                                
                                self.friendRequests.append(newRequest)
                                println(self.friendRequests.count)
                                //End Madness
                                
                            }
                            else {
                                println("Error getting name")
                            }
                        }
                    }
                }
        
            }
            else {
                println("Error getting requests")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //test that works
        var test:Request = Request(name: "WTFSWIFT")
        friendRequests.append(test)
        //real shit that doesnt
        Query()
        //data is not reloading im assuming its because the query takes longer than the table load
        requestTable.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendRequests.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var thisRequest:Request! = friendRequests[indexPath.row]
        
        var cell: requestCell = tableView.dequeueReusableCellWithIdentifier("requestCell") as requestCell
            cell.requestSender.text = thisRequest.getSender()
        return cell
    }
    
}