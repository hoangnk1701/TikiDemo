//
//  BaseEntity.swift
//  
//
//  Created by LuongHV on 12/3/16.
//  Copyright © 2017 My Vinaphone Digital Health, Inc. All rights reserved.
//

import UIKit
import ObjectMapper

public class BaseEntity: Mappable {
    
    required init() {
    }
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
    }
    
    deinit {
        print("\(self) deinit")
    }
}

public class DateTransformCustom: TransformType {
    
    public typealias Object = Date
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let timeInt = value as? Double {
            return Date(timeIntervalSince1970: TimeInterval(timeInt))
        }
        
        if let timeStr = value as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            var dateObj = dateFormatter.date(from: timeStr)
            if dateObj == nil {
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateObj = dateFormatter.date(from: timeStr)
            }
            return dateObj
        }
        
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss"
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
public class JSONDefaultStringTransform: TransformType {
    
    public typealias Object = String
    public typealias JSON = String
    
    init() {}
    public func transformFromJSON(_ value: Any?) -> String? {
        if let strValue = value as? String {
            return String(strValue)
        }
        return value as? String ?? ""
    }
    
    public func transformToJSON(_ value: String?) -> String? {
        if let intValue = value {
            return "\(intValue)"
        }
        return ""
    }
}
public class JSONStringToBoolTransform: TransformType {
    
    
    public typealias Object = Bool
    public typealias JSON = String
    
    init() {}
    public func transformFromJSON(_ value: Any?) -> Bool? {
        if let strValue = value as? String {
            return strValue.boolValue
        }
        return value as? Bool ?? false
    }
    
    public func transformToJSON(_ value: Bool?) -> String? {
        if let intValue = value {
            return "\(intValue)"
        }
        return nil
    }
}
public class JSONStringToIntTransform: TransformType {
    
    public typealias Object = Int64
    public typealias JSON = String
    
    init() {}
    public func transformFromJSON(_ value: Any?) -> Int64? {
        if let strValue = value as? String {
            return Int64(strValue)
        }
        return value as? Int64 ?? nil
    }
    
    public func transformToJSON(_ value: Int64?) -> String? {
        if let intValue = value {
            return "\(intValue)"
        }
        return nil
    }
}

