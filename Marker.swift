//
//  Marker
//  Weather
//
//  Created by Quentin Logie on 2/1/16.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import GoogleMaps
class Marker {
    
    static var url: String = "http://api.openweathermap.org/data/2.5/weather"
    static var appId: String = "4d1e230aba90addc95e3ea4bbb9a08cd"
    
    static func getWeatherIcon (arrayMarker: [GMSMarker], pos: Int) {
        let urlWeather = url + "?lat=" + String(arrayMarker[pos].position.latitude) + "&lon=" + String(arrayMarker[pos].position.longitude) + "&appid=" + appId
        WSController.getWeather(urlWeather) { weather, error in
            arrayMarker[pos].snippet = Temperature.kelvinFormatInDegre(weather!.main.temp) + " : " + weather!.weather[0].main
            print(pos)
            print(arrayMarker[pos].title)
            if(arrayMarker.count > pos + 1) {
                
                self.getWeatherIcon(arrayMarker, pos: pos+1);
            }
        }
    }
    
}
