//
//  ViewController.swift
//  Weather
//
//  Created by Quentin Logie on 1/7/16.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import CoreLocation

class Accueil: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var SearchBar: UISearchBar!
    var cityArray:[City] = []
    var cityFav:[City] = []
    var locationManager = CLLocationManager()
    var cityLocalisation:[City] = []
    
    var urlApiGoogle = "https://maps.googleapis.com/maps/api/geocode/json?"
    
    var apiKeyGoogle = "AIzaSyDnb5FccFdqX6NCYjcQ7E_35t5w4Wvpk7w"
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        let url = WSController.getUrlForCityFromLongLat(locationManager.location!.coordinate.longitude, lat: locationManager.location!.coordinate.latitude)
        WSController.getCity(url) { cities, error in
            if(cities!.count > 0) {
                self.cityLocalisation.append(cities![0])
                self.cityArray.append(cities![0])
            }

            //Remove Favorites from cityArray
            let realm = try! Realm()
            let fav = realm.objects(Favorite)
            
            //Add realm Favorites in cityFav & cityArray
            for fa in fav
            {
                self.cityFav.append(fa.toCity())
                self.cityArray.append(fa.toCity())
            }
            self.tableView.reloadData()
        }
    }
    
    //MARK: Table view
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityArray.count
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! CellCity
        
        cell.city?.text = self.cityArray[indexPath.row].city
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //MARK: Search Bar
    
    func searchBarSearchButtonClicked(searchbar: UISearchBar) {
        searchbar.resignFirstResponder()
        
        let text = SearchBar.text
        
        let url = WSController.getUrlForCityFromAddress(text!)
        
        WSController.getCity(url) { cities, error in
            self.cityArray = cities!
             //Remove Favorites from cityArray
            var cityToDelete: [City] = [City]()
            for c in self.cityArray {
            if self.cityFav.contains({ $0.city == c.city }) {
                cityToDelete.append(c)
                }
            }
            for c in cityToDelete {
                if let index = self.cityArray.indexOf({ $0.city == c.city }) {
                    self.cityArray.removeAtIndex(index)
                }
            }
            
            //concat cityFav & cityArray
            self.cityArray = self.cityLocalisation + self.cityFav + self.cityArray
            
            self.tableView.reloadData()   
        }
    }
    
    //MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goto_detail" {
            if let destinationVC = segue.destinationViewController as? Detail{
                if let tableIndex = tableView.indexPathForSelectedRow?.row {
                    destinationVC.city = self.cityArray[tableIndex]
                }
            }
        }
    }
    
    //MARK: Swipe
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?
    {
        let realm = try! Realm()
        
        let clickedCity: City = self.cityArray[indexPath.row]

        let addFavAction = UITableViewRowAction(style: .Normal, title: "Add Fav") { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            //Delete Fav
            if self.cityFav.contains({ $0.city == clickedCity.city }) {
                //remove from realm / cityFav / cityArray
                try! realm.write {
                    realm.deleteAll()
                }
                self.cityArray.removeAtIndex(indexPath.row)
                self.cityFav.removeAtIndex(indexPath.row - self.cityLocalisation.count)
                
                //Add cityFav to Realm
                for c in self.cityFav
                {
                    try! realm.write {
                        realm.add(c.toFavorite())
                    }
                }
                
                //Remove row in table view
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            //Add Fav
            else {
                //Remove row in table view
                
                self.cityArray.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
                // add favorite in realm / cityArray
                try! realm.write {
                    realm.add(clickedCity.toFavorite())
                }
                self.cityArray.insert(clickedCity, atIndex: self.cityFav.count + self.cityLocalisation.count)
                
                //Update Tableview
                tableView.beginUpdates()
                tableView.insertRowsAtIndexPaths([
                    NSIndexPath(forRow: self.cityFav.count + self.cityLocalisation.count, inSection: 0)
                    ], withRowAnimation: .Automatic)
                
                tableView.endUpdates()
                
                //add favorite in cityFav
                self.cityFav.append(clickedCity)
            }
            
        }
        
        // Buttons
        if self.cityFav.contains({ $0.city == clickedCity.city }) {
            addFavAction.backgroundColor = UIColor.redColor()
            addFavAction.title = "Supprimer"
        }
            //Button Add
        else {
            addFavAction.backgroundColor = UIColor.blueColor()
        }
        
        
        return [addFavAction]
        
    }
    
    //MARK: Localisation
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("didFailWithError: \(error.description)")
    }
    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print(locations.last?.coordinate.latitude)
//    }
}

