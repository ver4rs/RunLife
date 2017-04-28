//
//  FriendsTableViewController.swift
//  RuLife
//
//  Created by Martin Sekerák on 14.04.16.
//  Copyright © 2016 Martin Sekerák. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    var results = NSDictionary()
    var count = Int()
    var next = String()
    var previous = String()
    
    let url: String = "http://atlantis.cnl.sk:8000/workouts/"
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Friends Route"
        print("FriendsTableViewController")
        
        self.validUrl(url)
        //print(allData)

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //self.validUrl(self.url)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.results.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? WorkoutTableViewCell
    
        cell!.preservesSuperviewLayoutMargins = false
        cell!.separatorInset = UIEdgeInsetsZero
        cell!.layoutMargins = UIEdgeInsetsZero
        
        let dur = results["results"]![indexPath.row]["duration"] as? NSInteger
        
        cell?.dateLabel.text = convertDateFormater((results["results"]![indexPath.row]["pub_date"] as? String)!)
        cell?.imageType.image = UIImage(named: "Running Filled")
        
        cell?.titleLabel.text = String(format: "%@ %.2f km in %2d:%02d:%02d",
                                        (results["results"]![indexPath.row]["username"] as? String)!,
                                        (results["results"]![indexPath.row]["distance"] as? Float)! / 1000.0,
                                        Int(dur! / (1000*60*60) % 24),
                                        dur! / (1000*60) % 24,
                                        Int(dur! / 1000) )
        cell?.decriptionLabel.text = String(format: "%d kcal", 27)
        cell?.visibleIcon
        cell?.likeIcon
    
        return cell!
    }
    
    let month:NSArray = NSArray(array: ["Január", "Február", "Marec", "Apríl", "Máj", "Jún", "Júl",
        "August", "September", "Október", "November", "December"])
    
    func convertDateFormater(date: String) -> String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let date = dateFormatter.dateFromString(date)
        
        
        dateFormatter.dateFormat = "MMM dd  yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let timeStamp = dateFormatter.stringFromDate(date!)
        
        return timeStamp
    }

    
    func validUrl(sender: String?) {
        let url = NSURL(string: sender!)
        
        let controller = UIAlertController(title: "Invalid url", message: "Url is invalid", preferredStyle: UIAlertControllerStyle.Alert)
        
        if (UIApplication.sharedApplication().canOpenURL(url!)) {
            print("Url adress ", sender!, " is good")
            self.requestUrl(sender!)
        }
        else {
            
            let action = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            controller.addAction(action)
            
            presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    /*
        request url and connection with UIAlertAction
    */
    func requestUrl(url: String) {
        let HttpMethod = "GET"
        let timeOut = 15 //we have a 15- second timeout for connection
        
        let url = NSURL(string: url)
        
        //request here
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 15.0)
        
        urlRequest.HTTPMethod = HttpMethod
        
        let queue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue, completionHandler: { (response: NSURLResponse?, data: NSData?, error: NSError?) in
            //bla
            if (error != nil) {
                print("error \(error)")
                
                let controller = UIAlertController(title: "Invalid url", message: "Error: \(error!.localizedDescription)", preferredStyle: UIAlertControllerStyle.Alert)
                
                let action = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {(handler:UIAlertAction) -> Void in
                    
                    let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarHome") as! UITabBarController
                    
                    //self.navigationController?.pushViewController(secondViewController, animated: true)
                    self.presentViewController(secondViewController, animated: true, completion: nil)
                })
                controller.addAction(action)
                
                self.presentViewController(controller, animated: true, completion: nil)

            }
            else if data!.length > 0 && error == nil {
                //let html = NSString(data: data!, encoding: NSUTF8StringEncoding)
                let html = NSData(data: data!)
                //print("html = \(html) ")
                
                dispatch_async(dispatch_get_main_queue(), {
                    //self.table = html
                    self.extractJson(html)
                    
                    return
                })
            }
            else {
                print("error \(error)")
            }
            
        })
        
        
    }
    
    /*
        extract json serialization
    */
    func extractJson(data: NSData) {
        
        //let json: AnyObject?
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.dataFormat(json)
                
                return
            })
        }
        catch{
            print("error")
            //json = nil
            return
        }
        
        
    }
    
    /*
        json data formatted
    */
    func dataFormat(json: AnyObject) {
        
        let result = json["results"] as? [[String: AnyObject]]
        
        
        self.count = result!.count
        //self.next = json["next"] as! String
        //self.previous = json["previous"] as! String
        
        //print(allData)
        if json is NSDictionary {
            let aa = json as! NSDictionary
            self.results = json as! NSDictionary
            print("aa", self.results)
        }
        
        if self.results.count != 0 {
            self.table.reloadData()
            print("data reload to table")
            
        }
        
        //dispatch_async(dispatch_get_main_queue(), {
            //self.table.reloadData()
            print("hotovo")
            //print(self.allData)
            return
        //})
        
        
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

}
