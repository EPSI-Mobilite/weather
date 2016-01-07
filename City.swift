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
    var ville: String = ""
    var long: Float = 0.0
    var lat: Float = 0.0
    var cp: Int = 0
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        ville <- map["ville"]
        cp <- map["cp"]
        long <- map["long"]
        lat <- map["lat"]
    }
}