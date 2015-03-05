//
//  DestinationSearchViewController.swift
//  Where R U?
//
//  Created by John Behnke on 3/4/15.
//  Copyright (c) 2015 John Behnke. All rights reserved.
//

import UIKit
import MapKit

class DestinationSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating,MKMapViewDelegate {

    var locationManager :CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
    }
    
    //@IBOutlet weak var uiSearch: UISearchBar!
    var searchController: UISearchController!
    
    
    var searchResults:[MKMapItem]  = []
    var searchResultAddresses:[String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
       
        //self.searchController.searchBar.barTintColor = UIColor.redColor()
        self.searchController.searchBar.showsCancelButton = false
       self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0)
        
        self.tableView.tableHeaderView = self.searchController.searchBar

        self.searchController.searchBar.delegate = self
        
        self.definesPresentationContext  = true
        
        
        
        
    }

   override func viewWillAppear(animated: Bool) {
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
       let cell  = tableView.dequeueReusableCellWithIdentifier("destinationCell") as UITableViewCell
        getAddress(self.searchResults[indexPath.row])
        
        if searchResultAddresses.count != 0{
        var resultName: String = self.searchResults[indexPath.row].name
        
        println(searchResultAddresses.count)
         var addressName: String = self.searchResultAddresses[0]
        self.searchResultAddresses.removeAtIndex(0)

        
        //self.searchResultAddresses.removeAll(keepCapacity: false)
        
        println(searchResultAddresses.count)
        
        cell.textLabel?.text = resultName
        
        cell.detailTextLabel?.text = addressName
        return cell
        }
       return cell
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
         self.searchController.searchBar.showsCancelButton = false
            performSearch()
        self.tableView.reloadData()
    }
    

    
    //MARK: - MapKit Searching
    func performSearch() {
        
        self.searchResults.removeAll()
        self.searchResultAddresses.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = self.searchController.searchBar.text
        var currentLocation = CLLocation()
        var latDelta:CLLocationDegrees = 0.0001
        var longDelta:CLLocationDegrees = 0.0001
        var Span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude , longitude: currentLocation.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(center, Span)

        request.region = region
        let search = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler({(response: MKLocalSearchResponse!,
            error: NSError!) in
            
            if error != nil {
                println("Error occured in search: \(error.localizedDescription)")
            } else if response.mapItems.count == 0 {
                println("No matches found")
            } else {
                    for item in response.mapItems as [MKMapItem] {
                        //println("Name = \(item.name)")
                        
                        self.searchResults.append(item)
                        self.tableView.reloadData()
                        
                        CLGeocoder().reverseGeocodeLocation(item.placemark.location, completionHandler: {(placemarks, error) -> Void in
                            //println(item.placemark.location)
                            
                            if error != nil {
                                println("Reverse geocoder failed with error" + error.localizedDescription)
                                return
                            }
                            
                            if placemarks.count > 0 {
                                let pm: CLPlacemark = placemarks[0] as CLPlacemark
                            if pm.subThoroughfare != nil{
                                println(item.name + " " + pm.subThoroughfare + " " + pm.thoroughfare)}
                                //self.searchResultAddresses.append(pm)
                            self.tableView.reloadData()//}
                            }
//                            else {
//                                println("Problem with the data received from geocoder")
//                            }
                        })
                        
                        
                        
                    
                }
            }
        })
    }
    func getAddress(searchLocation: MKMapItem){
        
        var geocoder = CLGeocoder()
        var addressString : String = ""

        geocoder.reverseGeocodeLocation(searchLocation.placemark.location, completionHandler: {(placemarks, error)->Void in
            var placemark:CLPlacemark!
            
            if error == nil && placemarks.count > 0 {
                placemark = placemarks[0] as CLPlacemark
                
                                   if placemark.subThoroughfare != nil {
                        addressString = placemark.subThoroughfare + " "
                    }
                    if placemark.thoroughfare != nil {
                        addressString = addressString + placemark.thoroughfare + ", "
                    }
                    if placemark.postalCode != nil {
                        addressString = addressString + placemark.postalCode + " "
                    }
                    if placemark.locality != nil {
                        addressString = addressString + placemark.locality + ", "
                    }
                    if placemark.administrativeArea != nil {
                        addressString = addressString + placemark.administrativeArea + " "
                    }
                    if placemark.country != nil {
                        addressString = addressString + placemark.country
                    }
                }
                
                self.doi(addressString)
            //println(addressString)
            })
        }
    
    func doi(addressString: String){
        self.searchResultAddresses.append(addressString)

    }
}