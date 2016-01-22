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
    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var main: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        name.text = city.city
        
        let tmpUrl = url + "?zip=" + String(city.cp) + ",fr&appid=2de143494c0b295cca9337e1e96b00e0"
        //let tmpUrl = url + "?lat=35&lon=139&appid=2de143494c0b295cca9337e1e96b00e0"
        print(tmpUrl)
//        Alamofire.request(.GET, tmpUrl).responseJSON {
//            response in
//            //self.weather = response.result.value! as! Weather
//            debugPrint(response)
//        }
        
        Alamofire.request(.GET, tmpUrl)
            .responseObject { (response: Response<Weather, NSError>) in
                self.weather = response.result.value
                print(self.weather.weather?[0].main)
                
                self.main.text = self.weather.weather?[0].main
                self.temp.text = String(self.weather.main?.temp)
                
        }
    }
}