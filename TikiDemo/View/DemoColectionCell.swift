//
//  DemoColectionCell.swift
//  TikiDemo
//
//  Created by GOV-PM1-132 on 2/26/19.
//  Copyright © 2019 com.vnptsoftwarecompany. All rights reserved.
//

import UIKit
import PaddingLabel

class DemoColectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var labelContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelContent.layer.cornerRadius = 5
        labelContent.layer.masksToBounds = true
    }
    
    
}
