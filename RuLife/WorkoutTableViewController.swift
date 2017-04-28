//
//  WorkoutTableViewController.swift
//  RuLife
//
//  Created by Martin Sekerák on 08.03.16.
//  Copyright © 2016 Martin Sekerák. All rights reserved.
//

import UIKit
import CoreData

class WorkoutTableViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    
    var results = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.hidden = false

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
        self.fetchData()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.tabBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? WorkoutTableViewCell
        
        cell!.preservesSuperviewLayoutMargins = false
        cell!.separatorInset = UIEdgeInsetsZero
        cell!.layoutMargins = UIEdgeInsetsZero
        
        let row = self.results[indexPath.row]
        
        let dur = row.valueForKey("workout_duration") as! NSInteger
        
        cell?.dateLabel.text = convertDateFormater(row.valueForKey("workout_date") as! NSDate)
        cell?.imageType.image = UIImage(named: "Running Filled")
        cell?.titleLabel.text = String(format: "%.2f km in %2d:%02d:%02d",
                                    (row.valueForKey("workout_distance") as! Double) / 1000.0,
                                    Int(dur / (1000*60*60) % 24),
                                     dur / (1000*60) % 24,
                                    Int(dur / 1000) )
        cell?.decriptionLabel.text = String(format: "%d kcal", 27)
        cell?.visibleIcon
        cell?.likeIcon

        return cell!
    }
    
    let month:NSArray = NSArray(array: ["Január", "Február", "Marec", "Apríl", "Máj", "Jún", "Júl",
        "August", "September", "Október", "November", "December"])
    
    func convertDateFormater(date: NSDate) -> String {
        
        let dateFormatter = NSDateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        //        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        //        let date = dateFormatter.dateFromString(date as String)
        
        //MM 0-112 MMM Jul, Jan, MMMM Jul, Januar, December
        //dateFormatter.dateFormat = "dd.MM yyyy HH:mm"
        
        dateFormatter.dateFormat = "MMM dd  yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let timeStamp = dateFormatter.stringFromDate(date)
        
        return timeStamp
    }
    
    var item:Int = 0
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        item = indexPath.row
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SummaryView" {
            let vc:SummaryViewController = segue.destinationViewController as! SummaryViewController
            
            vc.data = self.results[item] as! Workout //full data workout and location
        }
        
    }

    
    func managedObjectContext() -> NSManagedObjectContext {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        
        return context
    }
    
    func fetchData() {
        let context = self.managedObjectContext()
        
        do {
            let request = NSFetchRequest(entityName: "Workout")
            //request.relationshipKeyPathsForPrefetching = [ "location" ]
            //request.predicate = NSPredicate(format: String, args: CVarArgType...)
            request.sortDescriptors = [ NSSortDescriptor(key: "workout_date", ascending: false) ]
            
            //let results:NSArray = try context.executeFetchRequest(request)
            results = try context.executeFetchRequest(request)
            
            //print(results)
            //for res in results {
                //print("ee: ", res.valueForKey("workout_date"))
                
                //for re in res.valueForKey("location") {
                //print("loc: ", res.valueForKey("location")!)
                //}
            //}
            //print(results)
            
            
        } catch {
            print("Dont error")
        }
    }


}
