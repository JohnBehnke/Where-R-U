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
    
    @IBOutlet var requestTable: UITableView!

    var friendRequests:[String] = []
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        requestTable.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendRequests.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        var cell: requestCell = tableView.dequeueReusableCellWithIdentifier("requestTableCell") as requestCell //this is the resualble cells
            cell.requestSender.text = "Johnsucks"
        
        return cell
    }
    
}