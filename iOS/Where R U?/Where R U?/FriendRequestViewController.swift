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
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //Make sure the data is up to date
       
    }
    
    @IBAction func backButtonTapped(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
}