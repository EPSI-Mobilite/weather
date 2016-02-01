//
//  DetailController.swift
//  Weather
//
//  Created by Quentin Logie on 2/1/16.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//
import Alamofire

class DetailController {
    
    static func getWeatherIcon (url: String) -> UIImage {
        let url = NSURL(string: url)
        let data = NSData(contentsOfURL: url!)
        return UIImage(data: data!)!
    }
    
    static func getWeather(url: String, completionHandler: (Weather?, NSError?) -> ()) {
        self.makeCall(url, completionHandler: completionHandler)
    }
    
    static func makeCall(url: String, completionHandler: (Weather?, NSError?) -> ()) {
        Alamofire.request(.GET, url)
            .responseObject { (response: Response<Weather, NSError>) in
                if (response.result.error == nil) {
                    completionHandler(response.result.value! as Weather, nil)
                }
        }
    }
}
