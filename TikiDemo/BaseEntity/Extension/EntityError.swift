//
//  EntityError.swift
//
//
//  Created by LuongHV on 3/8/17.
//  Copyright © 2017 My Vinaphone Digital Health, Inc. All rights reserved.
//

import UIKit
import ObjectMapper

class EntityError: BaseEntity {
    
    var timestamp: Int64?
    var status: Int?
    var error: String?
    var exception: String?
    var message: String?
    var path: String?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init() {
        super.init()
    }
    override func mapping(map: Map) {
        
        timestamp <- map["timestamp"]
        status <- map["status"]
        error <- map["error"]
        exception <- map["exception"]
        message <- map["message"]
        path <- map["path"]
    }
}
