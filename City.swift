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
    var geometry: Geometry!
    
    init (city: String, long: Float, lat : Float) {
        self.city = city
        let l = Location(long: long, lat: lat)
        let g = Geometry(location: l)
        
        self.geometry = g
        self.geometry.location.long = long
        self.geometry.location.lat = lat
    }
    
    required init?(_ map: Map) {
        
    }
    
    func getLat() -> Float {
        return self.geometry.location.lat
    }
    
    func getLong() -> Float {
        return self.geometry.location.long
    }
    
    func mapping(map: Map) {
        city <- map["formatted_address"]
        geometry <- map["geometry"]
    }
        
    func toFavorite() -> Favorite {
        return Favorite(city : self.city, long : self.geometry.location.long, lat : self.geometry.location.lat)
    }
}