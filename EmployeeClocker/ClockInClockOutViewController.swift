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

    @IBAction func clockInAction(sender: UIButton)
    {
        let query = PFQuery(className: "UserLocations")
        //query.findObjectsInBackgroundWithBlock{(objects,error) -> Void in
          //  if error == nil
            //{
              //  if let returnedobjects = objects
                //{
                  //  for object in returnedobjects
                    //{
                      //  print("Username is: ", object["username"] as! String)
                        //print("Clock in date is: ", object["clockInTime"] as! NSDate)
                        //print("Location is: ", object["location"] as! String)
                    //}
                //}
            //}
            
        //}
        
        //query constraint works cool
        query.whereKey("username", equalTo: usernameLabel.text!)
        //line will test all above constraints
        query.findObjectsInBackgroundWithBlock{(objects,error) -> Void in
            if error == nil{
                let arrayCurrentData = try! query.findObjects() as [PFObject]
                
                print("Testing constraints: ", arrayCurrentData)
            }
        }
        
    }
    
    
    @IBAction func clockOutAction(sender: UIButton) {
        
        let query = PFQuery(className: "UserLocations")
        //query constraint works cool
        query.whereKey("username", equalTo:usernameLabel.text!)
        //line will test all above constraints
        query.findObjectsInBackgroundWithBlock{(objects,error) -> Void in
            if error == nil{
                let arrayCurrentData = try! query.findObjects() as [PFObject]
                
                print("Testing constraints: ", arrayCurrentData)
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