//
//  City.swift
//  Weather
//
//  Created by Quentin Logie on 1/7/16.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class City : Mappable {
    var city: String!
    var long: Float = 0.0
    var lat: Float = 0.0
    var cp: Int = 0
    
    init (city: String, long: Float, lat : Float, cp : Int) {
        self.city = city
        self.long = long
        self.lat = lat
        self.cp = cp
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        city <- map["ville"]
        cp <- map["cp"]
        long <- map["long"]
        lat <- map["lat"]
    }
        
    func toFavorite() -> Favorite {
        
        return Favorite(city : self.city, long : self.long, lat : self.lat, cp : self.cp)
    }
}