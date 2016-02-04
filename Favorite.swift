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
    
    convenience required init (city: String, long: Float, lat : Float) {
        self.init()
        self.city = city
        self.long = long
        self.lat = lat
    }
    
    func getLat() -> Float {
        return self.lat
    }
    
    func getLong() -> Float {
        return self.long
    }

    func toCity() -> City {
        return City(city : self.city, long : self.long, lat : self.lat)
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
