//
//  UserMapViewController.swift
//  EmployeeClocker
//
//  Created by Admin on 1/25/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation
import Parse

protocol AddGeotificationsViewControllerDelegate {
    func addGeotificationViewController(controller: UserMapViewController, didAddCoordinate coordinate: CLLocationCoordinate2D,
        identifier: String, note: String, eventType: EventType)
}

class UserMapViewController: UITableViewController,MKMapViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var zoomButton: UIBarButtonItem!
    
    @IBOutlet weak var eventTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    
    @IBOutlet weak var userText: UILabel!
    @IBOutlet weak var employeeUsername: UILabel!
    @IBOutlet weak var detailTextField: UITextField!
    
    //var yourVariable:UIViewController!
    
    
    var manager:CLLocationManager!


    @IBAction func zoomToUserButton(sender: UIButton) {
        zoomToUserLocationInMapView(mapView)
    }
    
    
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var delegate: AddGeotificationsViewControllerDelegate!
    
    //will hold array of locations
    var myLocations: [CLLocation] = []
    var locationCoordinates: [CLLocationCoordinate2D] = []
    
    var descLocation: [PFGeoPoint] = []
    var temp: [CLLocationCoordinate2D] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeUsername.text = EmployeeLoginViewController().getUsername()
        
        addButton.enabled = false
        
        tableView.tableFooterView = UIView()
      
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        
        //check for location changes
        //if locations change, calls func locationManager
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
        
        
        //Setup our Map View
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        //load users previous data
        loadMapQuery()
        
        
    }
    
    

    func loadMapQuery() {
        
        let query = PFQuery(className: "UserLocations")
        //query constraint works cool
        query.whereKey("username", equalTo:EmployeeLoginViewController().getUsername())
        //line will test all above constraints
        query.findObjectsInBackgroundWithBlock{(objects,error) -> Void in
            if error == nil{
                if let returnedobjects = objects
                {
                    for object in returnedobjects
                    {
                        //print("Geopoint is: ", object["locationArray"])
                        self.descLocation = object["locationArray"] as! [PFGeoPoint]
                        //print("desclocation is: ", self.descLocation)
                          print("View controller LOADED")
                        print("Initial location is: ", self.descLocation[0])
                        
                        for index in 0...self.descLocation.count
                        {
                            let latitude: CLLocationDegrees = self.descLocation[index].latitude
                            let longtitude: CLLocationDegrees = self.descLocation[index].longitude
                            self.temp.append(CLLocationCoordinate2D(latitude: latitude, longitude: longtitude))
                            let polyline = MKPolyline(coordinates: &self.temp, count: self.temp.count)
                            
                            if self.mapView != nil{
                                self.mapView.addOverlay(polyline)
                            }
                        

                        }

                        
                    }
                }
            }
        }
        
    }
    
    
    //sets coordinates to details textfield everytime user moves
    //constantly called as location changes
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        
        
        
        if self.mapView == nil{
            mySwitch.setOn(false, animated: false);
        }
        
        if mySwitch.on {
            
            // switch is on
            let spanX = 0.007
            let spanY = 0.007
            var newRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
            mapView.setRegion(newRegion, animated: true)
            
        } else {
            //switch is off
        }
        
        
        
        detailTextField.text = "\(locations[0])"
        
        //creates location points into myLocations
        myLocations.append(locations[0] as! CLLocation)
        
        
        
        //supposed to draw line between points...
        if (myLocations.count > 1){
            var sourceIndex = myLocations.count - 2
            var destinationIndex = myLocations.count - 1
            
            let c1 = myLocations[sourceIndex].coordinate
            let c2 = myLocations[destinationIndex].coordinate
            locationCoordinates.append(c1)
                  
            
            
            var a = [c1, c2]
            //draws from point c1 to point c2
            //a hold two location points. Both with longitude and latitude values
            
            //so poly line data read from 'a' array
            //print("A is: ", a)'
            
            //and all longitudes and lat stored in myLocations array
            //print("My locations is: ", myLocations)
            
            //prints out array holding the coords
            //print("Location Coordinate is: ", locationCoordinates)
            
            //long and lat coordinates &a, count: a.count
            
            let polyline = MKPolyline(coordinates: &a, count: a.count)
            
            if self.mapView != nil{
                mapView.addOverlay(polyline)
            }
            
       
            
            
        }
    }
    
    
    //poly line testing
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 3
            return polylineRenderer
        }
        return nil
    }
    
    
    
    //deallocate map view when going back to previous screen
    @IBAction func backButton(sender: UIButton) {
            
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
        
        self.mapView.mapType = MKMapType.Hybrid
        self.mapView.mapType = MKMapType.Standard
        self.mapView.showsUserLocation = false;
        self.mapView.delegate = nil;
        self.mapView.removeFromSuperview()
        self.mapView = nil;

        
        
    }

    
    
}
