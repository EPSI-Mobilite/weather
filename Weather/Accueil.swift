//
//  ViewController.swift
//  Weather
//
//  Created by Quentin Logie on 1/7/16.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import UIKit
import Alamofire

class Accueil: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var SearchBar: UISearchBar!
    var cityArray:[City] = []
    var url = "http://www.citysearch-api.com/fr/city?login=weather&apikey=so48035e001f25344e90ca7e025cf846e2e9ea65cc"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Table view
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityArray.count
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        let city:City = self.cityArray[indexPath.row]
        
        cell.textLabel?.text = city.ville
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let city:City = cityArray[indexPath.row]
        print(city.cp);
    }
    
    //MARK: Search Bar
    
    func searchBarSearchButtonClicked(searchbar: UISearchBar) {
        searchbar.resignFirstResponder()
        
        let text = SearchBar.text
        
        url += "&ville="+text!
        print(url)
        Alamofire.request(.GET, url).responseArray("results") { (response: Response<[City], NSError>) in
            self.cityArray = response.result.value!
            self.tableView.reloadData()
        }
    }
}

