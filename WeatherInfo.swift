//
//  WeatherInfo.swift
//  Weather
//
//  Created by Alexis Gomes on 21/01/2016.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class WeatherInfo : Mappable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
}
