//
//  FriendRequestController.swift
//  Where R U?
//
//  Created by Zachary Minster on 2/24/15.
//  Copyright (c) 2015 John Behnke. All rights reserved.
//

import UIKit
import Foundation
import Parse


class FriendRequestViewController: UITableViewController,UITableViewDelegate, UITableViewDataSource{
    
    var profileVC: MyProfileViewController!
    
     var friendRequests:[Request] = []
    
    @IBOutlet var requestTable: UITableView!
    
    func Query() {
        //query database for friend request to current user
        var loadRequests:[Request] = []
        var friendshipQuery = PFQuery(className: "Friends")
        friendshipQuery.whereKey("user2", equalTo: PFUser.currentUser()!.objectId!)
        
       
        var objects:[AnyObject]?
        
        objects = friendshipQuery.findObjects()
        
        println("retrieved \(objects!.count) requests")
                
        if let objects = objects as? [PFObject] {
            for object in objects {
                //get userId of sender
                var userID = object.objectForKey("user1") as! String
                
                //query the user table for the name matching that userId
                var findUser:PFQuery = PFUser.query()!;
                findUser.whereKey("objectId",  equalTo: userID)
                //QUERYSEPTION
                var user:PFObject?
                user = findUser.getFirstObject()
                println(user)
                var username = user!.objectForKey("username") as! String
                
                //SWIFT PLS STAHP Q.Q
                println(username)
                //usernmae is retrieved succesfully, but the new request is not being appended to array
                //Create a new request with the received name
                var newRequest:Request = Request(name: username)
                
                self.friendRequests.append(newRequest)
                println(self.friendRequests.count)
               
                //End Madness

            }
    
        }
        self.requestTable.reloadData()

        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        Query()
        //requestTable.reloadData()
        

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
     
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func loadView() {
//        super.loadView()
//        //test that works
//        //var test:Request = Request(name: "WTFSWIFT")
//        //friendRequests.append(test)
//        //real shit that doesnt
//        Query()
//        //data is not reloading im assuming its because the query takes longer than the table load
//        requestTable.reloadData()
//    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendRequests.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
               var thisRequest: Request!
        thisRequest = self.friendRequests[indexPath.row]
        
        var cell: requestCell = tableView.dequeueReusableCellWithIdentifier("requestCell") as! requestCell
        cell.requestSender.text = thisRequest.getSender()
        

        return cell
    }
    
}