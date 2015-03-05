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
    
    var searchController: UISearchController!
    
    
    var searchResults:[String]  = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
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
        var resultName: String = self.searchResults[indexPath.row]
        
        println(resultName)
        cell.textLabel?.text = resultName
        return cell
    }
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
            performSearch()
        self.tableView.reloadData()
        
    }
    
    //MARK: - MapKit Searching
    func performSearch() {
        
        self.searchResults.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = self.searchController.searchBar.text
        var currentLocation = CLLocation()
        var latDelta:CLLocationDegrees = 0.0001
        var longDelta:CLLocationDegrees = 0.0001
        var Span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude , longitude: currentLocation.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(center, Span)

        request.region = region
      // println("TEST")
        
        let search = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler({(response:
            MKLocalSearchResponse!,
            error: NSError!) in
            
            if error != nil {
                println("Error occured in search: \(error.localizedDescription)")
            } else if response.mapItems.count == 0 {
                println("No matches found")
            } else {
               // println("Matches found")
                
                for item in response.mapItems as [MKMapItem] {
                    println("Name = \(item.name)")
                   // println("Phone = \(item.phoneNumber)")
                    
                    self.searchResults.append(item.name)
                    self.tableView.reloadData()
                   // println("Matching items = \(self.searchResults.count)")
                    
//                    var annotation = MKPointAnnotation()
//                    annotation.coordinate = item.placemark.coordinate
//                    annotation.title = item.name
//                    self.mapView.addAnnotation(annotation)
                }
            }
        })
    }

 }
