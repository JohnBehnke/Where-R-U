//
//  MyRidesViewController.swift
//  Where R U?
//
//  Created by John Behnke on 9/8/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import UIKit

class MyRidesViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    var isSingleRide = true
    @IBOutlet var rideTable: UITableView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
    }
    
    
    override  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            
            if isSingleRide{
                rideManager.oneTimeRides.removeAtIndex(indexPath.row)
                rideTable.reloadData()
            }
            
            else{
                rideManager.scheduledRides.removeAtIndex(indexPath.row)
                rideTable.reloadData()
            }
        }
        
    }
    
    
    
   
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        return rideTable.reloadData()
    }
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int{
        if isSingleRide{
            return rideManager.oneTimeRides.count
        }
        else{
            return rideManager.scheduledRides.count
        }
    }
    
      override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "test")
        if isSingleRide{
            cell.textLabel.text = rideManager.oneTimeRides[indexPath.row].getTitle()
            cell.detailTextLabel?.text = rideManager.oneTimeRides[indexPath.row].getDriver().getFirstName()
        
            return cell
        }
        else{
            cell.textLabel.text = rideManager.scheduledRides[indexPath.row].getTitle()
            cell.detailTextLabel?.text = rideManager.scheduledRides[indexPath.row].getDriver().getFirstName()
            return cell

        }
        
    }
}

