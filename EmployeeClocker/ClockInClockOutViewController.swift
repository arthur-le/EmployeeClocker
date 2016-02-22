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

 var yourVariable:UIViewController!

class ClockInClockOutViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    //set username
    @IBOutlet var usernameLabel: UILabel!
    
    var manager:CLLocationManager!

   
    @IBOutlet var locationLabel: UILabel!
    
    
    
    var geopointArray: [PFGeoPoint] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //set username
        usernameLabel.text = EmployeeLoginViewController().getUsername()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

    }
    
    

    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        
        
        geopointArray.append(PFGeoPoint(location: locations[0] as!CLLocation))
        
        print("Point is: ", geopointArray)
        
        
        let query = PFQuery(className: "UserLocations")
        query.whereKey("username", equalTo:usernameLabel.text!)
        //line will test all above constraints
        query.findObjectsInBackgroundWithBlock{(objects,error) -> Void in
            if error == nil{
                if let returnedobjects = objects
                {
                    for object in returnedobjects
                    {
                        //set PFgeopoint location to parse here:
                        object["locationArray"] = self.geopointArray
                        
                        
                        object.saveInBackground()
                        
                    }
                }
            }
        }
        
        
    }
    
    
    @IBAction func clockInAction(sender: UIButton)
    {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        
        }
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        
        
        let query = PFQuery(className: "UserLocations")
        //query constraint works cool
        query.whereKey("username", equalTo:usernameLabel.text!)
        //line will test all above constraints
        query.findObjectsInBackgroundWithBlock{(objects,error) -> Void in
            if error == nil{
                if let returnedobjects = objects
                {
                    for object in returnedobjects
                    {
                        print("Username is: ", object["username"] as! String)
                        let dateString1 = formatter.stringFromDate(object["clockInTime"] as! NSDate)
                        print("Previous clock in date is: ", dateString1)
                        
                        //Updates date
                        object["clockInTime"] = NSDate()
                        
                        let dateString = formatter.stringFromDate(object["clockInTime"] as! NSDate)
                        print("New clock in date is: ", dateString)
                        
                        self.locationLabel.text = dateString
                        object.saveInBackground()
                        

                    }
                }
            }
        }
        
        
        //trying to update date
        //look up updating objects on parse website to update date when button is clicked. Then set restraints
       // query.findObjectsInBackgroundWithBlock {
          //  (currentUser: PFObject?, error: NSError?) -> Void in
         //   if error != nil {
       //         print(error)
        //    } else if let currentUser = currentUser {
          //      currentUser["clockInTime"] = NSDate()
        //        currentUser.saveInBackground()
      //      }
    //    }

        
        

        
        //query constraint works cool
        //query.whereKey("username", equalTo: usernameLabel.text!)
        //line will test all above constraints
        //query.findObjectsInBackgroundWithBlock{(objects,error) -> Void in
            //if error == nil{
                //let arrayCurrentData = try! query.findObjects() as [PFObject]
                
                //print("Testing constraints: ", arrayCurrentData)
            //}
        //}
        
    }
    
    @IBAction func clockOutAction(sender: UIButton) {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        
        
        

        
        let query = PFQuery(className: "UserLocations")
        //query constraint works cool
        query.whereKey("username", equalTo:usernameLabel.text!)
        //line will test all above constraints
        query.findObjectsInBackgroundWithBlock{(objects,error) -> Void in
            if error == nil{
                if let returnedobjects = objects
                {
                  for object in returnedobjects
                  {
                    let dateString1 = formatter.stringFromDate(object["clockInTime"] as! NSDate)
                    print("Your clock in date and time was: ", dateString1)
                    
                    object["clockOutTime"] = NSDate()

                    
                    let dateString2 = formatter.stringFromDate(object["clockOutTime"] as! NSDate)
                    print("Your clock out date and time is: ", dateString2)
                    
                    object.saveInBackground()
                    
                    let startDate = object["clockInTime"] as! NSDate
                    let endDate = object["clockOutTime"] as! NSDate
                    let calendar = NSCalendar.currentCalendar()
                    //let datecomponenets = calendar.components(NSCalendarUnit.Second, fromDate: startDate, toDate: endDate, options: [])
                    //let hours = datecomponenets.hour
                    //let minutes = datecomponenets.minute
                    //let seconds = datecomponenets.second
                    
                    let hourMinuteComponents: NSCalendarUnit = [.Hour, .Minute, .Second]
                    let timeDifference = calendar.components(
                        hourMinuteComponents,
                        fromDate: startDate,
                        toDate: endDate,
                        options: [])
                    //timeDifference.hour
                    //timeDifference.minute
                    //timeDifference.second
                    
                    print("\nTotal Time Clock In Is:")
                    
                    print(timeDifference.hour, " Hours, ",timeDifference.minute, " Minutes, and ", timeDifference.second + 1, " Seconds.")


                  }
                }
            }
        }
    }
    
    
    
    @IBAction func confirmLocationButton(sender: UIButton) {
        //Setup our Location Manager
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        
        
       // if yourVariable == nil {
         //   let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
           // yourVariable = storyboard.instantiateViewControllerWithIdentifier("SecondViewController") as! UIViewController
       // }
        //self.presentViewController(yourVariable, animated: true, completion: nil)
        
        
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse{
            manager.startUpdatingLocation()
            timeToMoveOn()
        }
        
    }
    
    
    func timeToMoveOn() {
        self.performSegueWithIdentifier("transitionToMap", sender: self)
    }

    
    
    




}