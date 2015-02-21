//
//  LoginViewController.swift
//  Where R U?
//
//  Created by Zachary Minster on 2/21/15.
//  Copyright (c) 2015 John Behnke. All rights reserved.
//

import Foundation


class LoginViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate  {
    
    //Login Screen stuff

    //This function is run every time the view is opened? IDK why
    override func viewDidAppear(animated: Bool) {
        //Create Login
        super.viewDidAppear(animated)
        var currentUser = PFUser.currentUser()
        if currentUser == nil {
            var loginViewController:PFLogInViewController = PFLogInViewController()
            loginViewController.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.Default | PFLogInFields.PasswordForgotten | PFLogInFields.Facebook | PFLogInFields.SignUpButton;
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
}