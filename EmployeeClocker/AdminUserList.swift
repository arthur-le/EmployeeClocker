//
//  AdminUserList.swift
//  EmployeeClocker
//
//  Created by Admin on 3/2/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import Parse
var username: String = ""

class AdminUserList: UITableViewController {
    // MARK: Properties
    
    var meals = [Meal]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Load the sample data.
        loadSampleMeals()
      
    }
    
    func loadSampleMeals() {
        print("Loading samples meals function")
        
        var counter = 0
        var tempname = ""
        
        //so each object is a row essentially in the parse database
        let query = PFQuery(className: "UserLocations")
        //line will test all above constraints
        query.findObjectsInBackgroundWithBlock{(objects,error) -> Void in
            if error == nil{
                if let returnedobjects = objects
                {
                    for object in returnedobjects
                    {
                        counter = counter + 1
                        print("Number of objects is: " , counter)
                        
                        let photo = UIImage(named: "temp.jpg")!
                        tempname = object["username"] as! String
                        print("Tempname is: " , tempname)
                        
                        let newMeal = Meal(name: tempname, photo: photo)!
                        
                        //self.meals.append(newMeal)
                        self.meals += [newMeal]
                        
                        print("Meal array is: ", self.meals)

                        self.loadView()
                    }
                    
                }
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        
        //not calling?
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    //loads the given users map data from parse
    //should pass in users information
    
    func getUsername() -> String {
        return username
    }
    
    
    @IBAction func userMapButton(sender: UIButton){
        //calls correct row position to pass to array to pull correct data
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        
        username = meals[indexPath!.row].getUsername()
        print("Username at this row is: ", username)
    
        
    }
    
    
    
    
}
