//
//  EmployeeLoginViewController.swift
//
//  Created by Admin on 1/15/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import Parse
import Bolts

//globalvariable
var employeeUsername: String = ""


class EmployeeLoginViewController: UIViewController{

    
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func loginAction(sender: UIButton) {
        employeeUsername = usernameField.text!
        let password = self.passwordField.text
        
        let usernameLength = employeeUsername.characters.count
        let passwordLength = password?.characters.count
        
        // Validate the text fields
        if usernameLength <= 0 {
            let alert = UIAlertView(title: "Invalid", message: "Username must be greater than 5 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if passwordLength <= 0 {
            let alert = UIAlertView(title: "Invalid", message: "Password must be greater than 8 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else {
            // Run a spinner to show a task in progress
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            // Send a request to login
            //checks parse database for username and pw verification
            PFUser.logInWithUsernameInBackground((employeeUsername), password:(password)!, block: { (user, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                
                if ((user) != nil) {
                    let alert = UIAlertView(title: "Success", message: "Logged In As: " + employeeUsername, delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.performSegueWithIdentifier("EmployeeLoggedIn", sender: self)
                    })
                    
                } else {
                    let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
            })
        }

    }
    
    func getUsername() -> String
    {
        return (employeeUsername)
    }
  
    
    
    
    
    
}