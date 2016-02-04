//
//  WSController.swift
//  Weather
//
//  Created by Quentin Logie on 2/1/16.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//
import Alamofire

class WSController {
    
    static func getWeatherIcon (url: String) -> UIImage {
        let url = NSURL(string: url)
        let data = NSData(contentsOfURL: url!)
        return UIImage(data: data!)!
    }
    
    static func getWeather(url: String, completionHandler: (Weather?, NSError?) -> ()) {
        print(url)
        self.makeCallWeather(url, completionHandler: completionHandler)
    }
    
    static func makeCallWeather(url: String, completionHandler: (Weather?, NSError?) -> ()) {
        let u : String = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        Alamofire.request(.GET, u)
            .responseObject { (response: Response<Weather, NSError>) in
                if (response.result.error == nil) {
                    completionHandler(response.result.value! as Weather, nil)
                }
        }
    }
    
    static func getCity(url: String, completionHandler: ([City]?, NSError?) -> ()) {
        self.makeCallCity(url, completionHandler: completionHandler)
    }
    
    static func makeCallCity(url: String, completionHandler: ([City]?, NSError?) -> ()) {
        let u : String = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        Alamofire.request(.GET, u)
            .responseArray("results") { (response: Response<[City], NSError>) in
                if (response.result.error == nil) {
                    completionHandler(response.result.value! as [City], nil)
                }
        }
    }
}
