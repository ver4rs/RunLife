//
//  StartWorkoutViewController.swift
//  RuLife
//
//  Created by Martin Sekerák on 08.03.16.
//  Copyright © 2016 Martin Sekerák. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class StartWorkoutViewController: UIViewController, CLLocationManagerDelegate  {

    /*  stopwatch button defines outlet */
    @IBOutlet weak var startButtonLabel: UIButton! {
        didSet {
            startButtonLabel.backgroundColor = UIColor(red: 90/255.0, green: 195/255.0, blue: 175/255.0, alpha: 1)
            startButtonLabel.tintColor = UIColor.whiteColor()
            startButtonLabel.layer.borderWidth = 0
            //startButton.layer.cornerRadius = 8
            startButtonLabel.layer.borderColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1).CGColor
        }
    }
    @IBOutlet weak var pauseButtonLabel: UIButton!
    @IBOutlet weak var resumeButtonLabel: UIButton!
    @IBOutlet weak var finishButtonLabel: UIButton!
    /* END stopwatch button defined outlet  */
    
    
    /*  defined label for all lines  */
    @IBOutlet weak var durationLabel: UILabel! { didSet { self.durationLabel.text = "00:00:00" } }
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var avgSpeedLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var maxSpeedLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var avgPaceLabel: UILabel!
    
    
    
    /* button label top to turn on/off maps  */
    @IBOutlet weak var waipointMapButtonLabel: UIButton! {
        didSet {
            waipointMapButtonLabel.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
    }
   
    @IBOutlet weak var waipointMapLabel: UILabel!  { didSet { self.waipointMapLabel.text = "OFF" } }
    

    /*  icon gps strength receiving, searching,..  */
    @IBOutlet weak var gpsStrengthImage: UIImageView! { didSet { self.gpsStrengthImage.image = UIImage(named: "GPS Disconnected"); self.gpsStrength = 0 } }


    
    var data:[NSMutableArray] = []
    var location:[CLLocation] = []
    var distance:Double = 0.0
    var maxSpeed:Double = 0.0
    
    var isActiveMaps:Bool = false
    var gpsStrength:Int = 0
    
    let stopWatch = StopWatch()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearLabels() //clear labels to default value
        
        //default stopwatch button parameters
        self.pauseButtonLabel.hidden = true
        self.finishButtonLabel.hidden = true
        self.resumeButtonLabel.hidden = true

        
        //location
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest //warning and other results
        
        //tab bar
        self.tabBarController?.tabBar.hidden = true
        
        //custom data add
        let data1:NSMutableArray = ["DISTANCE", 324, "AVG. SPEED", 8.15]
        let data2:NSMutableArray = ["CALORIES", 327, "MAX SPEED", 9.24]
        self.data.append(data1)
        self.data.append(data2)
        
        //print(self.data[1])
        //self.data[1][1] = "ee"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackHome(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
 
    
    /*  maps button turn on/off maps  */
    @IBAction func mapsButton(sender: UIButton) {
        //print("tapped")
        if isActiveMaps {
            self.waipointMapButtonLabel.setImage(UIImage(named: "Waypoint Map"), forState: UIControlState.Normal)
            self.isActiveMaps = false
            self.waipointMapLabel.text = "OFF"
        }
        else {
            self.waipointMapButtonLabel.setImage(UIImage(named: "Waypoint-Map-Filled"), forState: UIControlState.Normal)
            self.isActiveMaps = true
            self.waipointMapLabel.text = "ON"
        }
        
    }
    
    /*
        start button
    */
    @IBAction func startButton(sender: UIButton) {
        self.pauseButtonLabel.hidden = false
        self.startButtonLabel.hidden = true
        self.resumeButtonLabel.hidden = true
        self.finishButtonLabel.hidden = true
        
        //is initial value
        self.durationLabel.text = "00:00:00"
        self.location.removeAll()
        self.distance = 0.0
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateElapsedTime:", userInfo: nil, repeats: true)
        stopWatch.start()
        
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func pauseButton(sender: UIButton) {
        self.pauseButtonLabel.hidden = true
        self.startButtonLabel.hidden = true
        self.resumeButtonLabel.hidden = false
        self.finishButtonLabel.hidden = false
        
        stopWatch.pause()
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func resumeButton(sender: UIButton) {
        self.pauseButtonLabel.hidden = false
        self.startButtonLabel.hidden = true
        self.resumeButtonLabel.hidden = true
        self.finishButtonLabel.hidden = true
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateElapsedTime:", userInfo: nil, repeats: true)
        stopWatch.resume()
        
        if #available(iOS 9.0, *) {
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
        } else {
            // Fallback on earlier versions
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func finishButton(sender: UIButton) {
        self.clearLabels()
        self.stopWatch.finish()
        
        self.pauseButtonLabel.hidden = true
        self.startButtonLabel.hidden = false
        self.resumeButtonLabel.hidden = true
        self.finishButtonLabel.hidden = true

        
        self.fullSaveData()
        
        //is initial value
        self.durationLabel.text = "00:00:00"
        self.distance = 0.0
        self.location.removeAll()
        
        locationManager.stopUpdatingLocation()
        
        //local notification to 24hours
        self.notification()
        
        //data sending to server
        self.sendDataToServer()
        
//        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("workout") as! WorkoutTableViewController
//        //self.presentViewController(vc, animated: true, completion: nil)
//        self.tabBarController?.presentViewController(vc, animated: true, completion: nil)
        
        // segue to home tab bar
        let story = UIStoryboard(name: "Main", bundle: nil)
        let tab = story.instantiateViewControllerWithIdentifier("tabBarHome") as! UITabBarController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = tab
        
    }

    
    func updateElapsedTime(timer: NSTimer){
        //print("updating...")
        
        if stopWatch.isRunning() {
            //durationLabel.text = stopWatch.elapsedTimeAsString
            self.durationLabel.text = stopWatch.elapsedTimeAsString
        } else {
            timer.invalidate()
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error map: \(error)")
        locationManager.stopUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //gps strength signal
        self.getGpsStrengthImage(locations[0].horizontalAccuracy)
        
        
        let actualLocation:CLLocation = locations[0] as CLLocation
        
        if location.count > 0 {
            let actualDistance = location.last?.distanceFromLocation(locations[0])
            
            //print(actualLocation.speed)
            if locations[0].speed > 0 {
                self.distance += actualDistance!  // resut is meters to del 1000
            }
            //print("actual dis: ", actualDistance)
            self.distanceLabel.text = String(format: "%.2f km", self.distance / 1000)
            
            var actualSpeed = locations[0].speed
            if actualSpeed <= 0 {
                actualSpeed = 0.0
            }
            actualSpeed = actualSpeed * 3.64
            self.avgSpeedLabel.text = String(format: "%.2f km/h", actualSpeed)
            
            //calories
            
            
            
            //max speed
            if self.maxSpeed < actualSpeed {
                self.maxSpeed = actualSpeed
            }
            self.maxSpeedLabel.text = String(format: "%.2f km/h", self.maxSpeed)
            
            //pace to one km ||||||
            
            
            //avg pace to one km
            let avgPace = 1000 / ( actualSpeed / 3.64 )
            self.avgPaceLabel.text = String(format: "%02d:%02d /km", Int(avgPace / 60), Int(avgPace % 60) )
            
        }
        
        if locations[0].speed > 0 {
            self.location.append(locations[0])
        }
        
    }
    
    /*
        func gps strength image
    */
    func getGpsStrengthImage(sender: Double) {
        switch sender {
        case -99999..<0: //no signal
            self.gpsStrengthImage.image = UIImage(named: "GPS Disconnected")
            self.gpsStrength = 0
        case 0..<48: // full signal
            self.gpsStrengthImage.image = UIImage(named: "GPS Receiving")
            self.gpsStrength = 3
        case 48..<163: //average signal
            self.gpsStrengthImage.image = UIImage(named: "GPS Receiving")
            self.gpsStrength = 2
        default: //poor signal
            self.gpsStrengthImage.image = UIImage(named: "GPS Searching")
            self.gpsStrength = 1
        }
        //print(self.gpsStrength)
    }
    
    
    func clearLabels() {
        self.durationLabel.text = "00:00:00"
        self.distanceLabel.text = "0.00 km/h"
        self.avgSpeedLabel.text = "0.00 km/h"
        self.caloriesLabel.text = "0 kcal"
        self.maxSpeedLabel.text = "0.00 km/h"
        self.paceLabel.text = "0:00 /km"
        self.avgPaceLabel.text = "0:00 /km"
    }

    //SAVE DATA
    
    // managedObjectContext
    func managedObjectContent() -> NSManagedObjectContext {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        
        return context
    }
    
    func fullSaveData() {
        let context = self.managedObjectContent()
        let identifier: NSDate = NSDate()
        
        //save workout
        let workout: Workout = NSEntityDescription.insertNewObjectForEntityForName("Workout", inManagedObjectContext: context) as! Workout
        workout.workout_identifier = "\(identifier)"
        workout.workout_date = NSDate()
        workout.workout_duration = self.stopWatch.elapsedTimeAsMillis // return Int to String
        workout.workout_distance = self.distance //meters
        
        do {
            try context.save()
            //print("ok1")
        } catch {
            print("Data workout dont saved")
        }//end saved workout
        
        
        //fetch data lastObject row
        do {
            let request = NSFetchRequest(entityName: "Workout")
            request.predicate = NSPredicate(format: "workout_identifier == '\(identifier)'")
            let results: NSArray = try context.executeFetchRequest(request)
            
            let oneRow: Workout = results.lastObject as! Workout
            //print(oneRow.objectID)
            
            //for and save data to second DB
            for i in 0 ..< self.location.count {
                let loc: Location = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: context) as! Location
                loc.location_identifier = "\(identifier)"
                loc.location_latitude = self.location[i].coordinate.latitude
                loc.location_longitude = self.location[i].coordinate.longitude
                loc.location_time = self.location[i].timestamp
                loc.workout = oneRow
                
                do {
                    try context.save()
                    //print("okk")
                } catch {
                    print("saved data location row")
                }
                
            }
            
        } catch {
            print("Dont fetched row in identifier ", identifier)
        }// end fetch data last row identifier
        
        
        
        
    }
    
    /*
        func sending data to server
    */
    var dataSending:Bool = true
    func sendDataToServer(){
        if dataSending == true {
            
            let username = "Martin_S"
            let duratio = self.stopWatch.elapsedTimeAsMillis
            let distan = self.distance
            _ = NSDate()
            
            let httpMethod = "POST"
            //var timeout = 15
            var urlString = "http://atlantis.cnl.sk:8000/workouts/"
            urlString += "?username=\(username)"
            urlString += "&duration=\(duratio)"
            urlString += "&distance=\(distan)"
            //urlString += "&pub_date=" + String(pub_date)
            print(urlString)
            
            let url = NSURL(string: urlString)
            //print(urlString)
            let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 15.0)
            
            urlRequest.HTTPMethod = httpMethod
            
            //post parameters
            let body = "username=\(username)&duration=\(duratio)&distance=\(distan)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            urlRequest.HTTPBody = body
            
            let queue = NSOperationQueue()
            
            NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue, completionHandler: { (response: NSURLResponse?, data: NSData?, error: NSError?) in
                
                if data?.length > 0 && error == nil {
                    let html = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print(html)
                    print("ok")
                    
                    // ALERTS
                    let controller: UIAlertController = UIAlertController(title: "Sending data", message: "Data sending to server.", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(paramAction: UIAlertAction!) -> Void in
                        print("this tapped!!!")
                        self.dataSending = false
                    })
                    controller.addAction(action)
                    
                    self.presentViewController(controller, animated: true, completion: nil)
                    
                    
                }
                else if data?.length == 0 && error == nil {
                    print("note data download")
                }
                else if error != nil {
                    print("Error is :\(error)")
                }
                
            })
            
            
        }

    }
    
    func notification() {
        //register and create UILocalNotification()
        let notification = UILocalNotification()
        
        //time and timezone settings
        notification.fireDate = NSDate(timeIntervalSinceNow: 60*60*24)
        notification.timeZone = NSCalendar.currentCalendar().timeZone
        //notification.repeatInterval = NSCalendarUnit.Minute
        
        notification.alertBody = "Dnes si este nebehal, preslo uz 24 hodin)"
        
        
        //action settings
        //notification.hasAction = true
        notification.alertAction = "View"
        notification.soundName = UILocalNotificationDefaultSoundName
        
        //badge settings
        notification.applicationIconBadgeNumber++
        
        //additional information, user info
        notification.userInfo = [
            "key1" : "value1",
            "key2" : "badge:\(notification.applicationIconBadgeNumber) date \(NSDate())"
        ]
        
        //schedule the notifications
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        print("func notification:", notification.applicationIconBadgeNumber)
    }


    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
