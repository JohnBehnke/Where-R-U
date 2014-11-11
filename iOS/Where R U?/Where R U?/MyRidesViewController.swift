//
//  MyRidesViewController.swift
//  Where R U?
//
//  Created by John Behnke on 9/8/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import UIKit

class MyRidesViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var rideTable: UITableView!
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        return rideTable.reloadData()
    }
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int{
        return rideManager.rides.count
        
    }
    
      override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "test")
        
        cell.textLabel.text = rideManager.rides[indexPath.row].name
        cell.detailTextLabel?.text = rideManager.rides[indexPath.row].driver
        
        return cell
        
    }
}

