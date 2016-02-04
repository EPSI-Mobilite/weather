//
//  Detail.swift
//  Weather
//
//  Created by Alexis Gomes on 21/01/2016.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import UIKit
import Alamofire
import SwiftLoader

class Detail:UIViewController {
    
    var city: City!
    var url: String = "http://api.openweathermap.org/data/2.5/weather"
    var weather:Weather?
    var appId: String = "4d1e230aba90addc95e3ea4bbb9a08cd"
    var urlImg = "http://openweathermap.org/img/w/"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var main: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        name.text = self.city.city
        let urlWeather = url + "?q=" + city.city + ",fr" + "&appid=" + appId
        SwiftLoader.show(animated: true)
        WSController.getWeather(urlWeather) { weather, error in
            self.weather = weather
            self.main.text = self.weather!.weather[0].main
            self.temp.text = String(Temperature.kelvinToCelsuis(self.weather!.main.temp))
            self.img.image = WSController.getWeatherIcon(self.urlImg + self.weather!.weather![0].icon + ".png")
            SwiftLoader.hide()
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event?.subtype == UIEventSubtype.MotionShake {
            SwiftLoader.show(animated: true)
            let urlWeather = url + "?q=" + self.city.city + ",fr" + "&appid=" + appId
            WSController.getWeather(urlWeather) { weather, error in
                self.weather = weather
                self.main.text = self.weather!.weather[0].main
                self.temp.text = String(Temperature.kelvinToCelsuis(self.weather!.main.temp))
                self.img.image = WSController.getWeatherIcon(self.urlImg + self.weather!.weather![0].icon + ".png")
                SwiftLoader.hide()
            }
        }
    }
}