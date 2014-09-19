//
//  MyRidesViewController.swift
//  Where R U?
//
//  Created by John Behnke on 9/8/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import UIKit

class MyRidesViewController: UIViewController {
    
    
    @IBAction func swipeToMap(sender:UISwipeGestureRecognizer) {
     
        self.tabBarController?.selectedIndex = 0
    }
    @IBAction func swipeToSetttings(sender:UISwipeGestureRecognizer) {
      
        self.tabBarController?.selectedIndex = 2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
                
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

