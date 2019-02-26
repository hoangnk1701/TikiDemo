//
//  UserInfoEntity.swift
//  DKTT
//
//  Created by ERP-PM2-0697 on 12/21/18.
//  Copyright © 2018 Duc Tran Trung. All rights reserved.
//

import UIKit
import ObjectMapper

public class TikiModel: BaseEntity {
    
    public var arrayKeywords: [TikiDetailModel]?
    required init() {
        super.init()
    }
    required init?(map: Map) {
        super.init(map: map)
    }
    override public func mapping(map: Map) {
        super.mapping(map: map)
        arrayKeywords <- map["keywords"]
    }
    
}

public class TikiDetailModel: BaseEntity {
    public var keyword : String?
    public var icon : String?
    required init() {
        super.init()
    }
    required init?(map: Map) {
        super.init(map: map)
    }
    override public func mapping(map: Map) {
        super.mapping(map: map)
        keyword <- map["keyword"]
        icon <- map["icon"]
    }
}
