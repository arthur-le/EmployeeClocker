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
    
    var myLocations: [CLLocation] = []
    
   
    
    @IBOutlet var locationLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //set username
        usernameLabel.text = EmployeeLoginViewController().getUsername()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.requestWhenInUseAuthorization();
        //self.manager.requestAlwaysAuthorization();
        manager.startUpdatingLocation()

    }

    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        
        
        //creates location points into myLocations
        myLocations.append(locations[0] as! CLLocation)
        
        //supposed to draw line between points...
        if (myLocations.count > 1){
            
            let c1 = myLocations[0].coordinate
            //a hold two location points. Both with longitude and latitude values

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
                        print("Clock in date is: ", object["clockInTime"] as! NSDate)
                        //set location here
                        object["clockInTime"] = NSDate()
                        
                        let dateString = formatter.stringFromDate(object["clockInTime"] as! NSDate)
                        
                        print("New clock in date is: ", dateString)
                        
                        self.locationLabel.text = dateString
                        object.saveInBackground()
                        
                        
                        print("Location is: ", self.myLocations[self.myLocations.count - 1])
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
                    print("Clock n date is: ", object["clockInTime"] as! NSDate)
                    print("Location is: ", object["location"] as! String)
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
            if yourVariable == nil {
                print("Testing current in inner should only show once")
                //yourVariable = storyboard!.instantiateViewControllerWithIdentifier("UserMap") as! UIViewController
             
                let yourVariable = self.storyboard!.instantiateViewControllerWithIdentifier("UserMap") as! UIViewController

            }
            print("testing now in outer")
            //self.presentViewController(yourVariable, animated: true, completion: nil)
            
            self.navigationController!.pushViewController(yourVariable, animated: true)
            //currently not working
            
    
            //timeToMoveOn()
        }
        
    }
    
    
    func timeToMoveOn() {
        //delelted the segue, gotta re-add if want to use
        self.performSegueWithIdentifier("transitionToMap", sender: self)
    }

    
    
    




}