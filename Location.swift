//  Created by Quentin Logie on 1/7/16.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class Location : Mappable {
    var long: Float!
    var lat: Float!
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        long <- map["lng"]
        lat <- map["lat"]
    }
    
}