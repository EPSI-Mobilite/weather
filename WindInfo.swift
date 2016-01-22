//
//  WindInfo.swift
//  Weather
//
//  Created by Alexis Gomes on 21/01/2016.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class WindInfo : Mappable {
    var speed: Float?
    var deg: Float?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        speed <- map["speed"]
        deg <- map["deg"]
    }
}