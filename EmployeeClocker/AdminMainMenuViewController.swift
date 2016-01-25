//
//  AdminMainMenuViewController.swift
// EmployeeClocker
//
//  Created by Admin on 1/22/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class AdminMainMenuViewController: UIViewController{

    @IBOutlet var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set username
        usernameLabel.text = AdminLoginViewController().getUsername()
        
    }

    
}