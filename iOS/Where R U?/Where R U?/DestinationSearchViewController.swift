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

    
    
    //MARK: - Class Variables
    var locationManager :CLLocationManager = CLLocationManager()
    var searchController: UISearchController!
    var searchResults:[MKMapItem]  = []
    var searchResultAddresses:[String] = []
    
    var addRideVC: AddRideViewController!
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    //MARK: - IBActions
   
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
         self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: - Default Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
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
    
    
    //MARK: - Table View Functions
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
       let cell  = tableView.dequeueReusableCellWithIdentifier("destinationCell") as UITableViewCell
        getAddress(self.searchResults[indexPath.row])
        
        if searchResultAddresses.count != 0{
            var resultName: String = self.searchResults[indexPath.row].name
        
       
            var addressName: String = self.searchResultAddresses[0]
            self.searchResultAddresses.removeAtIndex(0)
        
            cell.textLabel?.text = resultName
        
            cell.detailTextLabel?.text = addressName
            return cell
        }
       return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        self.addRideVC.destination =  self.searchResults[indexPath.row]
        
        self.addRideVC.rideDestination.text  = self.searchResults[indexPath.row].name
        
        self.navigationController?.popViewControllerAnimated(true)
        
        
    }
    
    //MARK: - Search Controller Functions
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.searchController.searchBar.showsCancelButton = false
        performSearch()
      
    }
    

    
    //MARK: - Helper Functions
    func performSearch() {
        
        self.searchResults.removeAll()
        self.searchResultAddresses.removeAll()
        
        let request = MKLocalSearchRequest()
        
        
        
        request.naturalLanguageQuery = self.searchController.searchBar.text
        
        var currentLocation = CLLocation()
        var latDelta:CLLocationDegrees = 0.6250
        var longDelta:CLLocationDegrees = 0.6250
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
                    if self.canAppend(self.searchResults, newDestination: item){
                        self.searchResults.append(item)
                    }
                    self.tableView.reloadData()
                     
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
                
                self.searchResultAddresses.append(addressString)
            }
        })
    }
    
    func canAppend(searchArray: [MKMapItem], newDestination: MKMapItem) -> Bool{
        
        for destination in searchArray{
            if destination == newDestination{
                return false
            }
        }
        return true
    }
}