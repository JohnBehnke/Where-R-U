//
//  File.swift
//  Where R U?
//
//  Created by Zachary Minster on 3/31/15.
//  Copyright (c) 2015 John Behnke. All rights reserved.
//


import UIKit

class requestCell: UITableViewCell {
    
    
    @IBOutlet weak var requestAccept: UIButton!
    
   
    @IBOutlet weak var requestDeny: UIButton!
   
    
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