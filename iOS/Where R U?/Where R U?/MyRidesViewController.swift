//
//  MyRidesViewController.swift
//  Where R U?
//
//  Created by John Behnke on 9/8/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import UIKit
import Foundation
import Parse



class MyRidesViewController: UITableViewController ,UITableViewDelegate, UITableViewDataSource, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    var isSingleRide = true
    
    var oneTimeRides:[Ride] = []
    
    var scheduledRides:[Ride] = []
    
    var addRideVC: AddRideViewController!
    
    
    //The Ride Table in the actual StoryBoard
    @IBOutlet var rideTable: UITableView!
    
    //2 button Selector that shows allows user to select which type of ride to view
    @IBAction func tableSelector(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex
        {
        case 0:
            isSingleRide = true
            rideTable.reloadData()
        case 1:
            isSingleRide = false
            rideTable.reloadData()
        default:
            break;
        }
        
    }
    
    //If the user wants to add a ride Segue
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        
        self.performSegueWithIdentifier("showRideAdd", sender: self)
        
    }
    
    
    @IBAction func newAddPressed(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showAdd", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var test: Bool = queryParse()
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        //self.rideTable.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func refresh(sender:AnyObject)
    {
       
        var test: Bool =   queryParse()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    func queryParse()-> Bool{
        
        if PFUser.currentUser() == nil{
            return false;
            
        }
        
        self.scheduledRides.removeAll()
        self.oneTimeRides.removeAll()
        if !IJReachability.isConnectedToNetwork(){
            
            var localRideQuery:PFQuery = PFQuery(className: "Ride")
            localRideQuery.whereKey("user", equalTo: PFUser.currentUser()!)
            localRideQuery.fromLocalDatastore()
            

            localRideQuery.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, error: NSError?) -> Void in
                if (error == nil){
                    let tempArray = objects!
                    for tempRide in tempArray {
                        println(tempRide["hrDest"] as! String)
                        
                        var newRide: Ride = Ride(title: tempRide["title"] as! String, description: "PULLED", destination: tempRide["hrDest"] as! String, seatsAvailable: 8, driver: Person(firstName: tempRide["driver"] as! String, lastName: "LOCAL DATASTORE", userName: PFUser.currentUser()!))
                        
                        //newRide.setParseID(tempRide["objectId"] as String)
                        if tempRide["isSingleTime"] as! Bool == true{
                            
                           
                            
                         self.oneTimeRides.append(newRide)
                        }
                        else{
                            self.scheduledRides.append(newRide)
                        }
                        self.rideTable.reloadData()
                        
                        
                        tempRide.pinInBackgroundWithBlock{ (success: Bool, error: NSError?) -> Void in
                            if success {
                                NSLog("Object created with id: \(tempRide.objectId)")
                            } else {
                                NSLog("%@", error!)
                            }
                        }
                    }
                }
                
            }
        }
        else{
            
            var localRideQuery:PFQuery = PFQuery(className: "Ride")
            localRideQuery.whereKey("user", equalTo: PFUser.currentUser()!)
            
            
            localRideQuery.findObjectsInBackgroundWithBlock{(objects: [AnyObject]?, error: NSError?) -> Void in
                //because we dont like errors
                if (error == nil){
                    
                    for tempRide in objects!{
                        println(tempRide["hrDest"] as! String)
                        
                        
                        
                        var newRide: Ride = Ride(title: tempRide["title"] as! String, description: "PULLED", destination: tempRide["hrDest"] as! String, seatsAvailable: 8, driver: Person(firstName: tempRide["driver"] as! String, lastName: "LOCAL DATASTORE", userName: PFUser.currentUser()!))
                        
                        println("loololol")
                        if tempRide["isSingleTime"] as! Bool == true{
                            self.oneTimeRides.append(newRide)
                        }
                        else{
                            self.scheduledRides.append(newRide)
                        }
                        self.rideTable.reloadData()
                        tempRide.pinInBackgroundWithBlock{ (success: Bool, error: NSError?) -> Void in
                            if success {
                                NSLog("Object created with id: \(tempRide.objectId)")
                            } else {
                                NSLog("%@", error!)
                            }
                        }
                        
                    }
                }
                
            }
            
        }
        //rideTable.reloadData()
        return true
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        parseLogin()
        
        //Make sure the data is up to date
        //rideTable.reloadData()
    }
    
    
    
    //Prepares to transition to another view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //If we are going to the Ride Detail VC
        if segue.identifier == "ShowRideDetail" {
            
            let detailVC: RideDetailViewController = segue.destinationViewController as! RideDetailViewController
            let indexPath = self.rideTable.indexPathForSelectedRow()
            var thisRide:Ride
            //Choose which array to send
            if isSingleRide{
                thisRide = oneTimeRides[indexPath!.row]
            }
            else{
                
                thisRide  = scheduledRides[indexPath!.row]
            }
            detailVC.detailRide = thisRide
        }
            //If we are  going to the Create a Ride VC
            
            
        else if segue.identifier == "showAdd"{
            
            var addRideVC:AddRideViewController = segue.destinationViewController as! AddRideViewController
            addRideVC.ridesVC = self
            
            
        }
    }
    
    //Fucntion for the slide to delete option on the table view
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            
            
            
            
            
            
            
            if isSingleRide{
                oneTimeRides.removeAtIndex(indexPath.row)
                rideTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                
                
            }
            else{
                scheduledRides.removeAtIndex(indexPath.row)
                rideTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
    
    //Returns the number of rows in the section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int{
        if isSingleRide{
            return oneTimeRides.count
        }
        else{
            return scheduledRides.count
        }
    }
    
    //Actually populates the table view with resuable prototype cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        println(":kjdfhdskjfhalsdkfhkhflk")
        var thisRide:Ride! //create a ride object
        
        if isSingleRide{
            thisRide  = oneTimeRides[indexPath.row]
        }
        else{
            thisRide = scheduledRides[indexPath.row]
        }
        
        var cell: rideCell = tableView.dequeueReusableCellWithIdentifier("rideTableCell") as! rideCell //this is the resualble cells
        
        if isSingleRide{
            cell.rideName.text = thisRide.getTitle()
            cell.rideDriver.text = thisRide.getDriver().getFirstName()
            cell.rideDestination.text = thisRide.getDestinationName()
            
        }
        else{
            cell.rideName.text = thisRide.getTitle()
            cell.rideDriver.text = thisRide.getDriver().getFirstName()
            cell.rideDestination.text = thisRide.getDestinationName()}
        return cell
    }
    
    
    //Gets ready to go to the Show Ride Detail view
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ShowRideDetail", sender: self)
    }
    
    //MARK: Parse Login
    
    func parseLogin(){
        
        var currentUser = PFUser.currentUser()
        if currentUser == nil {
            var loginViewController:PFLogInViewController = PFLogInViewController()
            loginViewController.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.Default | PFLogInFields.PasswordForgotten | PFLogInFields.Facebook | PFLogInFields.SignUpButton;
            presentViewController(loginViewController, animated: true, completion: nil)
            
            loginViewController.delegate = self
            loginViewController.signUpController!.delegate = self
            
        }
    }
    func logInViewController(logInViewController: PFLogInViewController,
        didLogInUser user: PFUser) {
            
            logInViewController.dismissViewControllerAnimated(true, completion: nil)
            
    }
    
    func logInViewController(logInViewController: PFLogInViewController!, didCancelLogIn user: PFUser!) {
        
        logInViewController.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}



