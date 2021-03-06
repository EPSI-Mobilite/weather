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
import RealmSwift

class Detail:UIViewController {
    
    var city: City!
    var url: String = "http://api.openweathermap.org/data/2.5/weather"
    var weather:Weather?
    var appId: String = "4d1e230aba90addc95e3ea4bbb9a08cd"
    var urlImg = "http://openweathermap.org/img/w/"
    var favArray:[City] = []
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var main: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var butFav: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        name.text = self.city.city
        butFav.setTitle("☆", forState: UIControlState.Normal)
        
        //Add realm Favorites in favArray
        let realm = try! Realm()
        let fav = realm.objects(Favorite)
        
        for fa in fav
        {
            self.favArray.append(fa.toCity())
        }
        
        let urlWeather = url + "?lat=" + String(city.getLat()) + "&lon=" + String(city.getLong()) + "&appid=" + appId
        SwiftLoader.show(animated: true)
        WSController.getWeather(urlWeather) { weather, error in
            self.weather = weather
            self.main.text = self.weather!.weather[0].main
            self.temp.text = Temperature.kelvinFormatInDegre(self.weather!.main.temp)
            self.img.image = WSController.getWeatherIcon(self.urlImg + self.weather!.weather![0].icon + ".png")
            SwiftLoader.hide()
            
            let realm = try! Realm()
            let fav = realm.objects(Favorite)
            if fav.contains({ $0.city == self.city.city }) {
                self.butFav.setTitle("⭐️", forState: UIControlState.Normal)
            }
            
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event?.subtype == UIEventSubtype.MotionShake {
            SwiftLoader.show(animated: true)
            let urlWeather = url + "?lat=" + String(city.getLat()) + "&lon=" + String(city.getLong()) + "&appid=" + appId
            WSController.getWeather(urlWeather) { weather, error in
                self.weather = weather
                self.main.text = self.weather!.weather[0].main
                self.temp.text = Temperature.kelvinFormatInDegre(self.weather!.main.temp)
                self.img.image = WSController.getWeatherIcon(self.urlImg + self.weather!.weather![0].icon + ".png")
                SwiftLoader.hide()
            }
        }
    }
    
    @IBAction func clickButtonFav(sender: AnyObject) {
        
        let realm = try! Realm()
        
        let favRealm = realm.objects(Favorite)
        if favRealm.contains({ $0.city == self.city.city }) { //Delete fav
            self.butFav.setTitle("☆", forState: UIControlState.Normal)
            
            //remove from realm
            try! realm.write {
                realm.deleteAll()
            }
            
            //Add favArray to Realm exept this city
            for f in self.favArray
            {
                if f.city != self.city.city {
                    try! realm.write {
                        realm.add(f.toFavorite())
                    }
                }
            }
            
        }
        else { //Add fav
            self.butFav.setTitle("⭐️", forState: UIControlState.Normal)
            
            try! realm.write {
                realm.add(self.city.toFavorite())
            }
        }
        
    }
    
}