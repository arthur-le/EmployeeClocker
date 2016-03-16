//
//  ViewController.swift
//
//  Created by Admin on 1/13/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class UserProfileScreenVC: UIViewController, UITextFieldDelegate {
    
    
    //MARK: Properties
    //name text field screen 1
    @IBOutlet weak var nameTextField: UITextField!
    //label connection
    @IBOutlet var employeeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
