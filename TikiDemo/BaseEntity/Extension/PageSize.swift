//
//  PageSize.swift
//  
//
//  Created by LuongHV on 3/6/17.
//  Copyright © 2017 My Vinaphone Digital Health, Inc. All rights reserved.
//

import UIKit
import ObjectMapper

class PageSize: Mappable {
    
    var q: String = ""
    var page: Int64 = 1
    var size: Int64 = 10
    var idFilter: String = ""
    
    required init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        q <- map["q"]
        page <- map["page"]
        size <- map["size"]
        idFilter <- map["idFilter"]
    }
    
}
