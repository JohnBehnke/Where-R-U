//
//  destinationCell.swift
//  Where R U?
//
//  Created by John Behnke on 3/7/15.
//  Copyright (c) 2015 John Behnke. All rights reserved.
//

import UIKit

class destinationCell: UITableViewCell {
    
    @IBOutlet weak var destinationName: UILabel!
    
    @IBOutlet weak var destinatoinAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
