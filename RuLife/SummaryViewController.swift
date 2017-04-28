//
//  SummaryViewController.swift
//  RuLife
//
//  Created by Martin Sekerák on 15.03.16.
//  Copyright © 2016 Martin Sekerák. All rights reserved.
//

//import Cocoa
import UIKit
import MapKit
import CoreData

import Social

class SummaryViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var dateTop: UILabel!
    
    // row 1
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    // row 2
    @IBOutlet weak var avgSpeed: UILabel!
    @IBOutlet weak var maxSpeed: UILabel!
    

    
    
    var data:Workout!
    var location = [CLLocation]()
    
    var annotation = [MKAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Summary"
        self.mapView.delegate = self
        
        self.tabBarController?.tabBar.hidden = true
        
        //self.navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButton:")
        
        let date = self.data.valueForKey("workout_date") as! NSDate
        self.dateTop.text = self.convertDateFormater(date)
        
        let dur = self.data.valueForKey("workout_duration") as! NSInteger
        self.durationLabel.text = String(format: "%2d:%02d:%02d", Int(dur / (1000*60*60) % 24), dur / (1000*60) % 24, Int(dur / 1000))
        
        let dis = self.data.valueForKey("workout_distance") as! Double
        self.distanceLabel.text = String(format: "%.2f km/h", dis / 1000)
        
        dispatch_async(dispatch_get_main_queue(), {
            self.convertData(self.data) // convert Workout data to CLLocation data
            
            self.mapPolyline(self.location)
            
            self.mapCenter(self.location, distance: self.data.valueForKey("workout_distance") as! Double)
            
            //self.mapAnnotation(self.location)
        })
        
        
        
    }
    
    /*
        func map center
    */
    func mapCenter(sender: [CLLocation], distance:Double) {
        
        //center
        if (sender.first != nil && sender.last != nil) {
            let lat = ((sender.first?.coordinate.latitude)! + (sender.last?.coordinate.latitude)! ) / 2
            let lon = ((sender.first?.coordinate.longitude)! + (sender.last?.coordinate.longitude)!) / 2
            let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            //            let span = MKCoordinateSpan(latitudeDelta: 0.020, longitudeDelta: 0.020)
            //            let region = MKCoordinateRegion(center: center, span: span)
            //            mapView.setRegion(region, animated: true)
            
            let region = MKCoordinateRegionMakeWithDistance(center, distance + 500, distance + 500)
            
            self.mapView.setRegion(region, animated: true)
            //print("ok")
        }

    }
    
    /*
        func map polyline
    */
    func mapPolyline(sender: [CLLocation]) {
        var coor:[CLLocationCoordinate2D] = []
        if sender.count != 0 {
            for var i=0; i<sender.count; i++ {
                
                //let coo = [ CLLocationCoordinate2D(latitude: sender[i].coordinate.latitude, longitude: sender[i].coordinate.longitude), CLLocationCoordinate2D(latitude: sender[i+1].coordinate.latitude, longitude: sender[i+1].coordinate.longitude) ]
                let co = CLLocationCoordinate2D(latitude: sender[i].coordinate.latitude, longitude: sender[i].coordinate.longitude)
                coor.append(co)
            }
            let polyline = MKPolyline(coordinates: &coor, count: coor.count)
            self.mapView.addOverlay(polyline, level: MKOverlayLevel.AboveLabels)
        }
    }
    
    /*
        func map marker--annotation
    */
    func mapAnnotation(sender: [CLLocation]) {
        let ano1 = MKPointAnnotation()
        let ano2 = MKPointAnnotation()
        ano1.coordinate = CLLocationCoordinate2D(latitude: (location.first?.coordinate.latitude)!, longitude: (location.first?.coordinate.longitude)!)
        ano2.coordinate = CLLocationCoordinate2D(latitude: (location.last?.coordinate.latitude)!, longitude: (location.last?.coordinate.longitude)!)
        ano1.title = "START"
        ano2.title = "END"
        
        let date: NSDate = (location.first?.timestamp)!
        let finalDate = NSDateFormatter()
        finalDate.dateFormat = "dd.MM yyyy hh:mm:SSS"
        ano1.subtitle = String(finalDate.stringFromDate(date))
        
        self.annotation.append(ano1)
        self.annotation.append(ano2)
        self.mapView.addAnnotations(annotation)

    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = MKPolylineRenderer(overlay: overlay)
        //polyline.lineDashPattern = [14,10,6,10,4,10]
        polyline.strokeColor = UIColor.redColor()
        polyline.lineWidth = 5
        
        return polyline
    }
    
    
    func convertData(sender:Workout) {
        let count = sender.valueForKey("location")?.count
        
        var manager = CLLocationManager()
        
        for var i=0; i<count; i++ {
            //print(CLLocation(latitude: sender.valueForKey("location")![i].valueForKey("location_latitude") as! Double, longitude: sender.valueForKey("location")![i].valueForKey("location_longitude") as! Double).horizontalAccuracy)
            
            let coo = CLLocationCoordinate2D(latitude: sender.valueForKey("location")![i].valueForKey("location_latitude") as! Double, longitude: sender.valueForKey("location")![i].valueForKey("location_longitude") as! Double)
            //let course = //CLLocation
            //let altitude =   //nadmorska vyska
            let time = sender.valueForKey("location")![i].valueForKey("location_time") as! NSDate
            
            let loc = CLLocation(coordinate: coo, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, timestamp: time)
            //let loc = CLLocation(latitude: sender.valueForKey("location")![i].valueForKey("location_latitude") as! Double, longitude: sender.valueForKey("location")![i].valueForKey("location_longitude") as! Double)
            
            self.location.append(loc)
            
            var location = CLLocation(latitude: sender.valueForKey("location")![i].valueForKey("location_latitude") as! Double, longitude: sender.valueForKey("location")![i].valueForKey("location_longitude") as! Double) //changed!!!
            //print(location)
            
//            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
//                print(location)
//                
//                if error != nil {
//                    print("Reverse geocoder failed with error" + error!.localizedDescription)
//                    return
//                }
//                
//                if placemarks!.count > 0 {
//                    let pm = placemarks![0] as! CLPlacemark
//                    print(pm)
//                }
//                else {
//                    print("Problem with the data received from geocoder")
//                }
//            })

            
        }
    }
    
    
    
    func convertDateFormater(date: NSDate) -> String {
        
        let dateFormatter = NSDateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        //        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        //        let date = dateFormatter.dateFromString(date as String)
        
        //MM 0-112 MMM Jul, Jan, MMMM Jul, Januar, December
        dateFormatter.dateFormat = "dd.MM yyyy HH:mm"
        //dateFormatter.dateFormat = "MMM dd  yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let timeStamp = dateFormatter.stringFromDate(date)
        
        return timeStamp
    }
    
    func backButton(){
        print("ok")
//        let vc:WorkoutTableViewController = aa.destinationViewController as! WorkoutTableViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("Workout") as! WorkoutTableViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func buttonDeleteWorkout(sender: UIBarButtonItem) {
        
        let context = self.managedObjectContext()
        
        let alert = UIAlertController(title: "Naozaj chcete vymazat?", message: "Vymazat.", preferredStyle: UIAlertControllerStyle.Alert)
        
        //Add Cancel-Action
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        //Add Save-Action
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive, handler: { (actionSheetController) -> Void in
            print("handle deleted action...")
            
            let fetchRequest = NSFetchRequest(entityName: "Workout")
            let predicate = NSPredicate(format: "workout_identifier == %@", self.data.valueForKey("workout_identifier") as! NSString )
            
            fetchRequest.predicate = predicate
            
            do {
                let fetchedEntities = try context.executeFetchRequest(fetchRequest) as! [Workout]
                
                //            for entity in fetchedEntities {
                //                context.deleteObject(entity)
                //            }
                if let entityToDelete = fetchedEntities.last! as? Workout {
                    print("entity: ", entityToDelete)
                    context.deleteObject(entityToDelete)
                }
                print("deleted")
            } catch {
                // Do something in response to error condition
                print("dont deleted")
            }
            
            // to confirmation delete save action
            do {
                try context.save()
            } catch {
                // Do something in response to error condition
            }
            
            
            //redirect!
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarHome") as! UITabBarController
            self.presentViewController(vc, animated: true, completion: nil)
            
            
        }))
        
        
        presentViewController(alert, animated: true, completion: nil)
        // ENDE
        
        
        
        //storyboard segue to back.
        //let story = self.storyboard?.instantiateViewControllerWithIdentifier("WorkoutTableView") as! WorkoutTableViewController
        //self.presentViewController(story, animated: true, completion: nil)
        //        let nav = UINavigationController()
        //        nav.popViewControllerAnimated(true)
        
    }
    
    
    @IBAction func buttonShareClicked(sender: UIBarButtonItem) {
        let text: NSString = NSString(string: "Day  is walking \(distanceLabel.text) km in \(durationLabel.text). Thanks app Run life.")
        let url = NSURL(string: "http://runlife.sk")
        let image = UIImage(named: "Running Filled")
        let activity:UIActivityViewController = UIActivityViewController(activityItems: [ text, url!, image! ], applicationActivities: nil)
        self.presentViewController(activity, animated: true, completion: nil)
        
//        let type = SLServiceTypeFacebook
//        if SLComposeViewController.isAvailableForServiceType(type) {
//            let serviceController = SLComposeViewController(forServiceType: type)
//            serviceController.setInitialText("Today workout is runlife")
//            serviceController.addImage(UIImage(named: "start"))
//            serviceController.addURL(NSURL(string: "http://runlife.sk"))
//            serviceController.completionHandler = {( result: SLComposeViewControllerResult) in
//                print("succesfully done")
//            }
//            self.presentViewController(serviceController, animated: true, completion: nil)
//        }
        
    }
    
    func managedObjectContext() -> NSManagedObjectContext {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        
        return context
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //let vc:ViewMapsViewController = segue.destinationViewController as! ViewMapsViewController
        
        var DestViewController = segue.destinationViewController as! UINavigationController
        let targetController = DestViewController.topViewController as! ViewMapsViewController

        
        targetController.location = self.location
    }
    
    override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue? {
        return nil
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    
}
