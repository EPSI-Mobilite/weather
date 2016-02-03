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

class Accueil: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var SearchBar: UISearchBar!
    var cityArray:[City] = []
    var cityFav:[City] = []
    
    var url = "http://www.citysearch-api.com/fr/city?login=weather&apikey=so48035e001f25344e90ca7e025cf846e2e9ea65cc"
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        let realm = try! Realm()
        let fav = realm.objects(Favorite)
    
        //Add realm Favorites in cityFav & cityArray
        for fa in fav
        {
            self.cityFav.append(fa.toCity())
            self.cityArray.append(fa.toCity())
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
        cell.cp?.text = String(self.cityArray[indexPath.row].cp)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //let city:City = cityArray[indexPath.row]
        //performSegueWithIdentifier("goto_detail", sender: self)
        
       // print(city.cp);
    }
    
    //MARK: Search Bar
    
    func searchBarSearchButtonClicked(searchbar: UISearchBar) {
        searchbar.resignFirstResponder()
        
        let text = SearchBar.text
        
        url += "&ville="+text!
        Alamofire.request(.GET, url).responseArray("results") { (response: Response<[City], NSError>) in
            self.cityArray = response.result.value!
            
            // Remove Favorites from cityArray
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
            self.cityArray = self.cityFav + self.cityArray
            
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
                self.cityFav.removeAtIndex(indexPath.row)
                
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
                self.cityArray.insert(clickedCity, atIndex: self.cityFav.count)
                
                //Update Tableview
                tableView.beginUpdates()
                tableView.insertRowsAtIndexPaths([
                    NSIndexPath(forRow: self.cityFav.count, inSection: 0)
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
    
}

