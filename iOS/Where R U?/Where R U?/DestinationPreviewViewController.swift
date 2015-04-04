//
//  DestinationPreviewViewController.swift
//  Where R U?
//
//  Created by John Behnke on 3/21/15.
//  Copyright (c) 2015 John Behnke. All rights reserved.
//

import UIKit
import MapKit

class DestinationPreviewViewController: UIViewController, MKMapViewDelegate {

    var destinationSearchVC: DestinationSearchViewController!
    
    var locationManager :CLLocationManager! = nil
    
    var location:MKMapItem!
    
    @IBOutlet weak var mapView: MKMapView!
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        if (CLLocationManager.locationServicesEnabled()){
            
            
            var latDelta:CLLocationDegrees = 0.01
            var longDelta:CLLocationDegrees = 0.01
            var Span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            let center = CLLocationCoordinate2D(latitude: location.placemark.location.coordinate.latitude , longitude: location.placemark.location.coordinate.longitude)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(center, Span)
            self.mapView.setCenterCoordinate(center, animated: true)
            self.mapView.setRegion(region, animated: true)
            
            
            var annotation = MKPointAnnotation()
            annotation.coordinate = location.placemark.coordinate
            annotation.title = location.name
            self.mapView.addAnnotation(annotation)
            
            
            
        }
    }



        // Do any additional setup after loading the view.
    

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
