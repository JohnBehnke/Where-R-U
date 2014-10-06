//
//  MyRidesViewController.swift
//  Where R U?
//
//  Created by John Behnke on 9/8/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import UIKit

class MyRidesViewController: UIViewController, FBLoginViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let permissions = ["user_about_me", "user_relationships", "user_birthday", "user_location"]
        PFFacebookUtils.logInWithPermissions(permissions) {
            (user, error) in
            if (user == nil) {
                if (error == nil) {
                    println("User cancelled FB login")
                }else{
                    println("FB login error: \(error)")
                }
            } else if user.isNew {
                println("User signed up and logged in with Facebook")
                
            } else {
                println("User logged in via Facebook")
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

