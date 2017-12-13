//
//  CloudsInfo.swift
//  Weather
//
//  Created by Alexis Gomes on 21/01/2016.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class CloudsInfo : Mappable {
    var all: Int!
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        all <- map["all"]    }
}
