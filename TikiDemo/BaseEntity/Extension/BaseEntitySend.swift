//
//  BaseEntitySend.swift
//  
//
//  Created by LuongHV on 12/5/16.
//  Copyright © 2017 My Vinaphone Digital Health, Inc. All rights reserved.
//

import UIKit

class BaseEntitySend: JSONSerializable {
}

protocol JSONRepresentable {
    var JSONRepresentation: [String: Any] { get }
}

protocol JSONSerializable: JSONRepresentable {
}

extension JSONSerializable {
    var JSONRepresentation: [String: Any] {
        var representation = [String: Any]()
        
        for case let (label?, value) in Mirror(reflecting: self).children {
            
            let subMirror = Mirror(reflecting: value)
            if subMirror.displayStyle == .optional {
                if subMirror.children.count == 0 {
                    representation[label] = NSNull()
                } else {
                    
                    switch value {
                    case let value as JSONRepresentable:
                        representation[label] = value.JSONRepresentation
                        
                    case let value as JSONSerializable:
                        representation[label] = value.JSONRepresentation
                        
                    case let value as BaseEntitySend:
                        representation[label] = value.JSONRepresentation
                    case let value as BaseEntity:
                        representation[label] = value.toJSON()
                        
                    case let value as Dictionary<String, JSONSerializable>:
                        representation[label] = value.map({$0.value.JSONRepresentation})
                        
                    case let value as Array<JSONSerializable>:
                        representation[label] = value.map({$0.JSONRepresentation})
                        
                    case let value as Dictionary<String, AnyObject>:
                        representation[label] = value
                        
                    case let value as Array<AnyObject>:
                        representation[label] = value
                        
                    case let value as Date:
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss"
                        representation[label] = dateFormatter.string(from: value)
                        
                    case let value as NSObject:
                        representation[label] = value
                        
                    default:
                        representation[label] = NSNull()
                        break
                    }
                }
            } else {
                
                switch value {
                case let value as JSONRepresentable:
                    representation[label] = value.JSONRepresentation
                    
                case let value as JSONSerializable:
                    representation[label] = value.JSONRepresentation
                    
                case let value as BaseEntitySend:
                    representation[label] = value.JSONRepresentation
                case let value as BaseEntity:
                    representation[label] = value.toJSON()
                    
                case let value as Dictionary<String, JSONSerializable>:
                    representation[label] = value.map({$0.value.JSONRepresentation})
                    
                case let value as Array<JSONSerializable>:
                    representation[label] = value.map({$0.JSONRepresentation})
                    
                case let value as Dictionary<String, AnyObject>:
                    representation[label] = value
                    
                case let value as Array<AnyObject>:
                    representation[label] = value
                    
                case let value as Date:
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss"
                    representation[label] = dateFormatter.string(from: value)
                    
                case let value as NSObject:
                    representation[label] = value
                    
                default:
                    representation[label] = NSNull()
                    break
                }

            }
        }
        return representation
    }
}

extension JSONSerializable {

    func toJSON() -> Data? {
        let representation = JSONRepresentation
        
        guard JSONSerialization.isValidJSONObject(representation) else {
            return nil
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: representation, options: [])
            return data//String(data: data, encoding: String.Encoding.utf8)
        } catch {
            return nil
        }
    }
    
    func toString() -> String? {
        let representation = JSONRepresentation
        
        guard JSONSerialization.isValidJSONObject(representation) else {
            return nil
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: representation, options: [])
            return String(data: data, encoding: String.Encoding.utf8)
        } catch {
            return nil
        }
    }
}
