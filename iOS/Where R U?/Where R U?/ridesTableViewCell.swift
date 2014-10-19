//
//  ridesTableViewCell.swift
//  Where R U?
//
//  Created by John Behnke on 10/19/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import UIKit

class ridesTableViewCell: UITableViewCell {

    @IBOutlet weak var rideLabel: UILabel!
    
    
    @IBOutlet weak var driverLabel: UILabel!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
