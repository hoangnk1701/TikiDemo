//
//  NetWorking.swift
//  My Vinaphone
//
//  Created by admin on 11/3/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import Alamofire

class NetWorking: NSObject {
    /// Method GET
    class func GET(url: String, parameters: [String: Any]?, completion:@escaping(([String: Any]?) -> ())) {
        
        if parameters != nil {
            
            print(parameters as Any)
        }
        Progress.showProgress()
        Alamofire.request(url).responseJSON { (respone) in
            Progress.dismissProgress()
            print("JSON:\(respone) - url:\(url) - param:\(String(describing: parameters?.description))")
            switch respone.result{
                
            case .failure(let error):
                print("URL_ERROR:\(url) - mes:\(error.localizedDescription)")
                completion(nil)
                break
            case .success(let value):
                print("respone:\(value)")
                if let data = value as? [String: Any] {
                    completion(data)
                } else {
                    completion(nil)
                }
                
                break
                
            }
        }
    }
}
