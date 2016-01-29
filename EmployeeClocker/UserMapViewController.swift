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


protocol AddGeotificationsViewControllerDelegate {
    func addGeotificationViewController(controller: UserMapViewController, didAddCoordinate coordinate: CLLocationCoordinate2D,
        identifier: String, note: String, eventType: EventType)
}

class UserMapViewController: UITableViewController,MKMapViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var zoomButton: UIBarButtonItem!
    
    @IBOutlet weak var eventTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!

    
    @IBOutlet var mySwitch: UISwitch!
    
    
    
    @IBOutlet var userText: UILabel!
    @IBOutlet var employeeUsername: UILabel!
    @IBOutlet var detailTextField: UITextField!
    
    
       
    
    
    var manager:CLLocationManager!


    @IBAction func zoomToUserButton(sender: UIButton) {
        zoomToUserLocationInMapView(mapView)
    }
    
    
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var delegate: AddGeotificationsViewControllerDelegate!
    
    //will hold array of locations
    var myLocations: [CLLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeUsername.text = EmployeeLoginViewController().getUsername()
        
        //navigationItem.rightBarButtonItems = [addButton, zoomButton]
        addButton.enabled = false
        
        tableView.tableFooterView = UIView()
        
      
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        }
        
        //check for location changes
        //if locations change, calls func locationManager
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
        
        
        //Setup our Map View
        mapView.delegate = self
        mapView.showsUserLocation = true
        
     
    }
    
    //sets coordinates to details textfield everytime user moves
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        print("LOCATION UPDATINGGGG")
        
        
        if mySwitch.on {
            print("Switch is on")
            
            // switch is on
            let spanX = 0.007
            let spanY = 0.007
            var newRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
            mapView.setRegion(newRegion, animated: true)
            
        } else {
            print("Switch is off")
            
        }
        
        
        
        detailTextField.text = "\(locations[0])"
        
        //creates location points into myLocations
        myLocations.append(locations[0] as! CLLocation)
        
        if (myLocations.count > 1){
            var sourceIndex = myLocations.count - 1
            var destinationIndex = myLocations.count - 2
            
            let c1 = myLocations[sourceIndex].coordinate
            let c2 = myLocations[destinationIndex].coordinate
            var a = [c1, c2]
            var polyline = MKPolyline(coordinates: &a, count: a.count)
            mapView.addOverlay(polyline)
        }
    }
    
    @IBAction func textFieldEditingChanged(sender: UITextField) {
        addButton.enabled = !radiusTextField.text!.isEmpty && !noteTextField.text!.isEmpty
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction private func onAdd(sender: AnyObject) {
        var coordinate = mapView.centerCoordinate
        //var radius = Double(radiusTextField.text!)
        var identifier = NSUUID().UUIDString
        var note = noteTextField.text
        var eventType = (eventTypeSegmentedControl.selectedSegmentIndex == 0) ? EventType.OnEntry : EventType.OnExit
        delegate!.addGeotificationViewController(self, didAddCoordinate: coordinate, identifier: identifier, note: note!, eventType: eventType)
    }
    
    @IBAction private func onZoomToCurrentLocation(sender: AnyObject) {
        zoomToUserLocationInMapView(mapView)
    }
}
