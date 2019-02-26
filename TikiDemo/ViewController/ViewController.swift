//
//  ViewController.swift
//  TikiDemo
//
//  Created by GOV-PM1-132 on 2/26/19.
//  Copyright © 2019 com.vnptsoftwarecompany. All rights reserved.
//

import UIKit
import FSPagerView
import SDWebImage

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

class ViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var model: TikiModel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate let arrColor = ["#16702e","#005a51","#996c00","#5c0a6b","#006d90","#996c00","#974e06","#99272e","#89221f","#00345d"]
    
     //MARK: UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.model != nil {
            return self.model.arrayKeywords?.count ?? 0
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! DemoColectionCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: DemoColectionCell, indexPath: IndexPath) {
         let modelDetail: TikiDetailModel = self.model.arrayKeywords![indexPath.row]
        cell.labelContent.text = modelDetail.keyword
        cell.imageIcon.sd_setImage(with: URL(string: modelDetail.icon ?? ""), placeholderImage: UIImage.init(named: ""))
        
        
        if arrColor.count < indexPath.row + 1 {
            cell.labelContent.backgroundColor = UIColor(hexString: arrColor[indexPath.row - arrColor.count])
        } else {
           cell.labelContent.backgroundColor = UIColor(hexString: arrColor[indexPath.row])
        }
        
    }
    
    //MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // When user selects the cell
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        // When user deselects the cell
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getListData()
    }

    fileprivate let imageNames = ["baner1.png","baner2.jpg","baner3.jpg","baner4.jpg"]
    fileprivate var numberOfItems = 4
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = FSPagerView.automaticSize
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.imageNames.count
            self.pageControl.contentHorizontalAlignment = .right
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    // MARK:- FSPagerView DataSource
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.numberOfItems
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = index.description+index.description
        return cell
    }
    
    // MARK:- FSPagerView Delegate
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        switch sender.tag {
        case 1:
            let newScale = 0.5+CGFloat(sender.value)*0.5 // [0.5 - 1.0]
            self.pagerView.itemSize = self.pagerView.frame.size.applying(CGAffineTransform(scaleX: newScale, y: newScale))
        case 2:
            self.pagerView.interitemSpacing = CGFloat(sender.value) * 20 // [0 - 20]
        case 3:
            self.numberOfItems = Int(roundf(sender.value*7.0))
            self.pageControl.numberOfPages = self.numberOfItems
            self.pagerView.reloadData()
        default:
            break
        }
    }
    
     // MARK:- Call API
    func getListData() {
        
        NetWorking.GET(url:  "https://tiki-mobile.s3-ap-southeast-1.amazonaws.com/ios/keywords.json", parameters: nil) { (data) in
            if data != nil {
                self.model = TikiModel(JSON: data!)!
                print("hoang: ", self.model.arrayKeywords as Any)
                let modelDetail: TikiDetailModel = self.model.arrayKeywords![1]
                print("hoang: ", modelDetail.keyword as Any)
                self.collectionView.reloadData()
            } else  {
                print("data nil")
            }
        }
    }

}

