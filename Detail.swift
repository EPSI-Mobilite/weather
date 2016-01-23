//
//  Detail.swift
//  Weather
//
//  Created by Alexis Gomes on 21/01/2016.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import UIKit
import Alamofire

class Detail:UIViewController {
    
    var city: City!
    var url: String = "http://api.openweathermap.org/data/2.5/weather"
    var weather:Weather!
    var appId: String = "44db6a862fba0b067b1930da0d769e98"
    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var main: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        name.text = city.city
        
        let tmpUrl = url + "?lat=" + String(city.lat) + "&lon=" + String(city.long) + "&appid=" + appId
        
        Alamofire.request(.GET, tmpUrl)
            .responseObject { (response: Response<Weather, NSError>) in
                self.weather = response.result.value
                
                self.main.text = self.weather.weather![0].main
                print(self.weather.main!.temp)
                self.temp.text = String(Temperature.kelvinToCelsuis(self.weather.main!.temp))
                
        }
    }
}