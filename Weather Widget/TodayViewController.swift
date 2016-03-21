//
//  TodayViewController.swift
//  Weather Widget
//
//  Created by Alexis Gomes on 07/02/2016.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreLocation

class TodayViewController: UIViewController, NCWidgetProviding {

    var locationManager = CLLocationManager()
    var cityLocalisation:[City] = []
    
    var urlApiGoogle = "https://maps.googleapis.com/maps/api/geocode/json?"
    var apiKeyGoogle = "AIzaSyDnb5FccFdqX6NCYjcQ7E_35t5w4Wvpk7w"
    var url: String = "http://api.openweathermap.org/data/2.5/weather"
    var weather:Weather?
    var appId: String = "4d1e230aba90addc95e3ea4bbb9a08cd"
    
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var city: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.city.setTitle("??", forState: UIControlState.Normal);
        self.temp.text = "??";
        self.preferredContentSize = CGSizeMake(0, 70);
        self.updateData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        self.updateData()
        completionHandler(NCUpdateResult.NewData)
    }
    
    func widgetMarginInsetsForProposedMarginInsets
        (defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
            return UIEdgeInsetsZero
    }
    

    func updateData() {
        //locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()

        //Location Authorized or not
        if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways) {
            let url = WSController.getUrlForCityFromLongLat(locationManager.location!.coordinate.longitude, lat: locationManager.location!.coordinate.latitude)
            
            //Get city
            WSController.getCity(url) { cities, error in
                if(cities!.count > 0) {
                    self.cityLocalisation.append(cities![0])
                    self.city.setTitle(cities![0].city, forState: UIControlState.Normal)
                    self.temp.text = "??"
                    print(cities![0].city)
                    let urlWeather = self.url + "?lat=" + String(cities![0].getLat()) + "&lon=" + String(cities![0].getLong()) + "&appid=" + self.appId
                    
                    //Get Weather
                    WSController.getWeather(urlWeather) { weather, error in
                        self.weather = weather
                        print("update weather")
                        //self.main.text = self.weather!.w!eather[0].main
                        let temperature = Temperature.kelvinToCelsuis(self.weather!.main.temp)
                        self.temp.text = (NSString(format: "%.2f", temperature) as String) + " °C"
                        print(self.weather!.main.temp)
                    }
                    
                }
            }
        }
    }
    
    @IBAction func OnclickCity(sender: AnyObject) {
        self.extensionContext!.openURL(NSURL(string:"WeatherEPSI://Map")!, completionHandler: nil)
    }
}
