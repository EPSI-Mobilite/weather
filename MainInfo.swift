//
//  MainInfo.swift
//  Weather
//
//  Created by Alexis Gomes on 21/01/2016.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class MainInfo : Mappable {
    var temp: Float = 0.0
    var humidity: Float?
    var pressure: Float?
    var temp_min: Float?
    var temp_max: Float?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        temp <- map["temp"]
        humidity <- map["humidity"]
        pressure <- map["pressure"]
        temp_min <- map["temp_min"]
        temp_max <- map["temp_max"]
    }
}