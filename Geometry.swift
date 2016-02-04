//  Created by Quentin Logie on 1/7/16.
//  Copyright © 2016 Alexis Gomes Quentin Logie. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class Geometry : Mappable {
    var location: Location!
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        location <- map["location"]
    }
    
}