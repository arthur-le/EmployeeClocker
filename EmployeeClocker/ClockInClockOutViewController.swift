//
//  ClockInClockOutViewController.swift
//
//  Created by Admin on 1/20/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import CoreLocation

class ClockInClockOutViewController: UIViewController{
    
    //set username
    @IBOutlet var usernameLabel: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //set username
        usernameLabel.text = EmployeeLoginViewController().getUsername()
        //initialize loaction manager

        
    }
    
    //intialize location manager for potential location use


    
    @IBAction func clockInButton(sender: UIButton) {
        //confirm location is on
        
        
        
        
    }

    
    @IBAction func clockOutButton(sender: UIButton) {
        
    }
    
    
    @IBAction func showCurrentLocation(sender: UIButton) {
    }
    
   

}