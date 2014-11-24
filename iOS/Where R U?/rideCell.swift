//
//  rideCell.swift
//  Where R U?
//
//  Created by John Behnke on 11/23/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import UIKit

class rideCell: UITableViewCell {

    
    @IBOutlet weak var rideName: UILabel!
    
    
    @IBOutlet weak var rideDestination: UILabel!
    
    
    @IBOutlet weak var rideDriver: UILabel!
    
    
    @IBOutlet weak var rideDate: UILabel!
    
    
    @IBOutlet weak var rideETA: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
