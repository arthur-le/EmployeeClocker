//
//  ViewController.swift
//
//  Created by Admin on 1/13/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    //MARK: Properties
    //name text field screen 1
    @IBOutlet weak var nameTextField: UITextField!
    //label connection
    @IBOutlet var employeeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Handle text field user input through delegate callback
      //  nameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    //whats a delegate do
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        //Hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        employeeLabel.text = textField.text
    }
    
    
    //MARK: Actions
    //Button 1 properties
    @IBAction func changeLabelButton(sender: UIButton) {
 //       employeeLabel.text = "Button label changed"
    }
    

}
