//
//  MargirLabel.swift
//  TikiDemo
//
//  Created by GOV-PM1-132 on 2/26/19.
//  Copyright © 2019 com.vnptsoftwarecompany. All rights reserved.
//

import UIKit

class MargirLabel: UILabel {


    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        super.drawText(in: rect.inset(by: padding))
    }


}
