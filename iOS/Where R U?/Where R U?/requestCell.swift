//
//  File.swift
//  Where R U?
//
//  Created by Zachary Minster on 3/31/15.
//  Copyright (c) 2015 John Behnke. All rights reserved.
//


import UIKit

class requestCell: UITableViewCell {
    
    
    
    @IBAction func requestAccept(sender: AnyObject) {
    }
    
    @IBAction func requestDeny(sender: AnyObject) {
    }
    
    @IBOutlet weak var requestSender: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}