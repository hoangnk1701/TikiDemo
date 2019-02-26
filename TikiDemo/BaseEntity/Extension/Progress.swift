//
//  Progress.swift
//  My Vinaphone
//
//  Created by admin on 11/3/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import SVProgressHUD

class Progress: NSObject {
    
    class func showProgress() {
        SVProgressHUD.setMaximumDismissTimeInterval(30)
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setForegroundColor(#colorLiteral(red: 0, green: 0.631372549, blue: 0.8941176471, alpha: 1))
        SVProgressHUD.setBackgroundColor(UIColor.white)
    }
    class func dismissProgress() {
        
        SVProgressHUD.dismiss()
    }
    
}
