//
//  IntroScreenViewController.swift
//
//  Created by Admin on 1/15/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class IntroScreenViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        _ = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "timeToMoveOn", userInfo: nil, repeats: false)
    }
    
    func timeToMoveOn() {
        self.performSegueWithIdentifier("SplashTransition", sender: self)
    }
    
}