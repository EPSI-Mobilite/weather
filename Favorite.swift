//
//  Favorite.swift
//  Weather
//
//  Created by Alexis Gomes on 01/02/2016.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import Foundation
import RealmSwift

class Favorite: Object {
    dynamic var city: String!
    dynamic var long: Float = 0.0
    dynamic var lat: Float = 0.0
    dynamic var cp: Int = 0
    
    convenience required init (city: String, long: Float, lat : Float, cp : Int) {
        self.init()
        self.city = city
        self.long = long
        self.lat = lat
        self.cp = cp
    }

     func toCity() -> City {
        return City(city : self.city, long : self.long, lat : self.lat, cp : self.cp)
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
