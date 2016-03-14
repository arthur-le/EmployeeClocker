//
//  AdminViewOfUserMapVC.swift
//  EmployeeClocker
//
//  Created by Admin on 3/2/16.
//  Copyright © 2016 Admin. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation
import Foundation
import Parse

//protocol AddGeotificationsViewControllerDelegate {
  //  func addGeotificationViewController(controller: UserMapViewController, didAddCoordinate coordinate: CLLocationCoordinate2D,
    //    identifier: String, note: String, eventType: EventType)
//}

class AdminViewOfUserMapVC: UITableViewController,MKMapViewDelegate{
    
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var zoomButton: UIBarButtonItem!
    
    @IBOutlet weak var eventTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    
    
    @IBOutlet var mySwitch: UISwitch!
    
    
    @IBOutlet var userText: UILabel!
    @IBOutlet var employeeUsername: UILabel!
    @IBOutlet var detailTextField: UITextField!
    
    //var yourVariable:UIViewController!
    
    
    //var manager:CLLocationManager!

    
    
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var delegate: AddGeotificationsViewControllerDelegate!
    
    //will hold array of locations
    var myLocations: [CLLocation] = []
    var locationCoordinates: [CLLocationCoordinate2D] = []
    
    var descLocation: [PFGeoPoint] = []
    var temp: [CLLocationCoordinate2D] = []
    
    var middleOfMap: Int = 0
    var templatitude: CLLocationDegrees = 0.0
    var templongitude: CLLocationDegrees = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.showsUserLocation = false;
        
        employeeUsername.text = AdminUserList().getUsername()
        
        
        tableView.tableFooterView = UIView()
        
        
        //manager = CLLocationManager()
        //manager.delegate = self
        //manager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        
        //check for location changes
        //if locations change, calls func locationManager
        
        
        //Setup our Map View
        mapView.delegate = self
   
        
        //load users previous data
        loadMapQuery()
        
       
        
        //to fit to coordinates
        //MKCoordinateRegionMake
        
        //if let coordinate = mapView.userLocation.location?.coordinate {
        //    let region = MKCoordinateRegionMakeWithDistance(coordinate, 9000, 9000)
          //  mapView.setRegion(region, animated: true)
       // }
        
        
    }
    
    
    func loadMapQuery() {
        
        let query = PFQuery(className: "UserLocations")
        //query constraint works cool
        query.whereKey("username", equalTo:AdminUserList().getUsername())
        //line will test all above constraints
        query.findObjectsInBackgroundWithBlock{(objects,error) -> Void in
            if error == nil{
                if let returnedobjects = objects
                {
                    for object in returnedobjects
                    {
                        //print("Geopoint is: ", object["locationArray"])
                        if object["locationArray"] != nil
                        {
                            self.descLocation = object["locationArray"] as! [PFGeoPoint]
                            //print("desclocation is: ", self.descLocation)
                            print("View controller LOADED")
                            print("Initial location is: ", self.descLocation[0])
                            print("Array length is: ", self.descLocation.count)
                            print("Final location is: ", self.descLocation[self.descLocation.count - 1] )
                            
                            self.middleOfMap = self.descLocation.count/2
                            print("Middle of the map is: ", self.middleOfMap)
                            self.templatitude = self.descLocation[self.middleOfMap].latitude
                            self.templongitude = self.descLocation[self.middleOfMap].longitude
                            
                            //potential fix
                            // if let coordinate = mapView.userLocation.location?.coordinate {
                            //    let region = MKCoordinateRegionMakeWithDistance(coordinate, 9000, 9000)
                            //     mapView.setRegion(region, animated: true)
                            // }
                            
                            
                            //set zoom levels to our coordinates
                            print("Self longitude is: ", self.templongitude)
                            print("Self latitude is: ", self.templatitude)
                            let span = MKCoordinateSpanMake(0.075, 0.075)
                            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.templatitude, longitude: self.templongitude), span: span)
                            self.mapView.setRegion(region, animated: true)
                            
                            for index in 0...self.descLocation.count
                            {
                                let latitude: CLLocationDegrees = self.descLocation[index].latitude
                                let longitude: CLLocationDegrees = self.descLocation[index].longitude
                                self.temp.append(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                                let polyline = MKPolyline(coordinates: &self.temp, count: self.temp.count)
                                self.mapView.addOverlay(polyline)
                                
                                
                            }

                        }
                        else{
                            //set label here that user has not clocked in yet
                            //set detail label here
                        }
                       
                        
                    }
                 
                    
                }
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
    


    
    
    @IBAction func backButton(sender: UIButton) {
        
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
            print("BACK BUTTON HIT")
        }
        print("BACK BUTTON HIT")
        
        self.mapView.mapType = MKMapType.Hybrid
        self.mapView.mapType = MKMapType.Standard
        self.mapView.showsUserLocation = false;
        self.mapView.delegate = nil;
        self.mapView.removeFromSuperview()
        self.mapView = nil;

    }
    
}