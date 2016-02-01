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
import Parse

class ClockInClockOutViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    //set username
    @IBOutlet var usernameLabel: UILabel!
    
    var manager:CLLocationManager!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //set username
        usernameLabel.text = EmployeeLoginViewController().getUsername()

    }

    @IBAction func clockInAction(sender: UIButton) {
        
        var query = PFQuery(className:"UserLocation")
        query.whereKey("username", equalTo:EmployeeLoginViewController().getUsername())
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully confirmed \(objects!.count) username.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    @IBAction func confirmLocationButton(sender: UIButton) {
        //Setup our Location Manager
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.requestAlwaysAuthorization();
        manager.startUpdatingLocation()
        

        
        if CLLocationManager.authorizationStatus() == .AuthorizedAlways{
            print("Location ALWAYS APPROVEDDDD")
            manager.startUpdatingLocation()
            timeToMoveOn()
        }
        
    }
    
    
    func timeToMoveOn() {
        print("Entering time to move on")
        self.performSegueWithIdentifier("transitionToMap", sender: self)
    }

    
    
    




}