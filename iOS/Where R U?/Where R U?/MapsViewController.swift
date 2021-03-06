//
//  mapsViewController.swift
//  Where R U?
//
//  Created by John Behnke on 9/8/14.
//  Copyright (c) 2014 John Behnke. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController, MKMapViewDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate  {
    
    var locationManager :CLLocationManager! = nil
    var theMapView: MKMapView! = nil
    
    
    //Login Screen stuff
    
    override func viewDidAppear(animated: Bool) {
        //Create Login
        var currentUser = PFUser.currentUser()
        if currentUser == nil {
            var loginViewController:PFLogInViewController = PFLogInViewController()
            loginViewController.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.Facebook | PFLogInFields.SignUpButton;
            presentViewController(loginViewController, animated: true, completion: nil)
            loginViewController.delegate = self
            loginViewController.signUpController.delegate = self
        }
    }
    
    func logInViewController(logInViewController: PFLogInViewController!,
        didLogInUser user: PFUser!) {
            
            logInViewController.dismissViewControllerAnimated(true, completion: nil)
            
    }
    
    func logInViewController(logInViewController: PFLogInViewController!,
        didCancelLogIn user: PFUser!) {
            
            logInViewController.dismissViewControllerAnimated(true, completion: nil)
            
    }
    //End Login Screen
    
    //Sign Up Screen
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //End Signup
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            var uName = PFUser.currentUser().username
            var me = Person(firstName: "first",lastName: "last",userName: uName)
            if (CLLocationManager.locationServicesEnabled()){
                
                me.updateLocation()
                
                let location = me.getLocation()
                var latDelta:CLLocationDegrees = 0.01
                var longDelta:CLLocationDegrees = 0.01
                var Span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
                let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude , longitude: location.coordinate.longitude)
                let region:MKCoordinateRegion = MKCoordinateRegionMake(center, Span)
                
                self.theMapView.setCenterCoordinate(center, animated: true)
                self.theMapView.setRegion(region, animated: true)
                
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

