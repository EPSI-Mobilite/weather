//
//  Weather.swift
//  Weather
//
//  Created by Alexis Gomes on 21/01/2016.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class Weather : Mappable {
    var sys: SysInfo?
    var weather: [WeatherInfo]?
    var base: String?
    var main: MainInfo?
    var wind: WindInfo?
    var clouds: CloudsInfo?
    var dt: Int?
    var id: Int?
    var name: String?
    var cod : Int?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        sys <- map["sys"]
        weather <- map["weather"]
        base <- map["base"]
        main <- map["main"]
        wind <- map["wind"]
        clouds <- map["clouds"]
        dt <- map["dt"]
        id <- map["id"]
        name <- map["name"]
        cod <- map["cod"]
    }
}