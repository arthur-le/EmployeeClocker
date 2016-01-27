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
    
    @IBOutlet var userText: UILabel!
    
    let manager = CLLocationManager()


    @IBAction func zoomToUserButton(sender: UIButton) {
        zoomToUserLocationInMapView(mapView)
    }
    
    
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var delegate: AddGeotificationsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.rightBarButtonItems = [addButton, zoomButton]
        addButton.enabled = false
        
        tableView.tableFooterView = UIView()
        
      
        
        let manager = CLLocationManager()
      
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        }
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
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
