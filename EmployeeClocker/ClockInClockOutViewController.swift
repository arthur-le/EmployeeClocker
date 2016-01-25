//
//  ClockInClockOutViewController.swift
//
//  Created by Admin on 1/20/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class ClockInClockOutViewController: UIViewController{
    
    //set username
    @IBOutlet var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set username
        usernameLabel.text = EmployeeLoginViewController().getUsername()
        
     
    }


}