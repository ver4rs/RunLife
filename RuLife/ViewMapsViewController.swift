//
//  ViewMapsViewController.swift
//  RuLife
//
//  Created by Martin Sekerák on 30.03.16.
//  Copyright © 2016 Martin Sekerák. All rights reserved.
//

import UIKit
import MapKit

class ViewMapsViewController: UIViewController, MKMapViewDelegate {
    
    var location:[CLLocation] = []

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentMapIndex: UISegmentedControl!
    
    @IBAction func segmentMaps(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0: mapView.mapType = MKMapType.Standard
            case 1: mapView.mapType = MKMapType.Hybrid
            case 2: mapView.mapType = MKMapType.Satellite
        default: mapView.mapType = MKMapType.Standard
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        self.mapView.delegate = self
        
        self.mapPolyline(self.location)
        self.mapCenter(self.location, distance: 300)
        mapView.setNeedsDisplay()
    }
    
    
    /*
        map center location
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
            
            mapView.setRegion(region, animated: true)
            //print("ok")
        }
        
    }
    
    func mapPolyline(sender: [CLLocation]) {
        var coor:[CLLocationCoordinate2D] = []
        if sender.count != 0 {
            for var i=0; i<sender.count; i++ {
                
                //let coo = [ CLLocationCoordinate2D(latitude: sender[i].coordinate.latitude, longitude: sender[i].coordinate.longitude), CLLocationCoordinate2D(latitude: sender[i+1].coordinate.latitude, longitude: sender[i+1].coordinate.longitude) ]
                let co = CLLocationCoordinate2D(latitude: sender[i].coordinate.latitude, longitude: sender[i].coordinate.longitude)
                coor.append(co)
            }
            let polyline = MKPolyline(coordinates: &coor, count: coor.count)
            mapView.addOverlay(polyline, level: MKOverlayLevel.AboveLabels)
        }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = MKPolylineRenderer(overlay: overlay)
        //polyline.lineDashPattern = [14,10,6,10,4,10]
        polyline.strokeColor = UIColor.redColor()
        polyline.lineWidth = 5
        
        return polyline
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        //sender.view
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
