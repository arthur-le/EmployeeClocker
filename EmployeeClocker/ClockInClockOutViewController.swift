//
//  ClockInClockOutViewController.swift
//
//  Created by Admin on 1/20/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Foundation

class ClockInClockOutViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    //set username
    @IBOutlet var usernameLabel: UILabel!
    
    var manager:CLLocationManager!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //set username
        usernameLabel.text = EmployeeLoginViewController().getUsername()

    }

    
    @IBAction func confirmLocationButton(sender: UIButton) {
        //Setup our Location Manager
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse{
            manager.startUpdatingLocation()
            print("Location is approved")
            
            timeToMoveOn()
        }
        
    }
    
    
    func timeToMoveOn() {
        self.performSegueWithIdentifier("transitionToMap", sender: self)
    }

    
    
    




}