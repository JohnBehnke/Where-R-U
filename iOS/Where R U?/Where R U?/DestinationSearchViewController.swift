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
    //var addressString:String!
    
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
        
        self.searchController.searchBar.translucent  = true
        
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
        
        var tempAddressString: String = ""
        let cell  = tableView.dequeueReusableCellWithIdentifier("destinationCell") as UITableViewCell
        
        var placemark = self.searchResults[indexPath.row].placemark
        //v//ar tempAddressString: String
        
        
        if placemark.subThoroughfare != nil {
            tempAddressString += placemark.subThoroughfare + " "
        }
        if placemark.thoroughfare != nil {
            tempAddressString +=  placemark.thoroughfare + ", "
        }
        if placemark.postalCode != nil {
            tempAddressString +=  placemark.postalCode + " "
        }
        if placemark.locality != nil {
            tempAddressString +=   placemark.locality + ", "
        }
        if placemark.administrativeArea != nil {
            tempAddressString +=  placemark.administrativeArea + " "
        }
        if placemark.country != nil {
            tempAddressString += placemark.country
        }

        
        //addressString = self.searchResults[indexPath.row].placemark.subThoroughfare + " " + self.searchResults[indexPath.row].placemark.thoroughfare
        
        
        
            var resultName: String = self.searchResults[indexPath.row].name
        
           // if searchResultAddresses.count != 0{
            //var addressrownName: String = self.searchResultAddresses[0]
            //self.searchResultAddresses.removeAtIndex(0)
        //getAddress(self.searchResults[indexPath.row])
        
        cell.detailTextLabel?.text = tempAddressString
            //self.addressString.removeAll(keepCapacity: true)
        
        
        //}
        cell.textLabel?.text = resultName
        
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
        
        
        var searchString: String =  self.searchController.searchBar.text
        
        
        
        searchString = searchString.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        request.naturalLanguageQuery = searchString
        
        var currentLocation = CLLocation()
        var latDelta:CLLocationDegrees = 0.01
        var longDelta:CLLocationDegrees = 0.01
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
    
    
    
    func canAppend(searchArray: [MKMapItem], newDestination: MKMapItem) -> Bool{
        
        for destination in searchArray{
            if destination == newDestination{
                return false
            }
        }
        return true
    }
}