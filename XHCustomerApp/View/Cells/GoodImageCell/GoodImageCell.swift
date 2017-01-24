//
//  GoodImageCell.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2017/1/18.
//  Copyright © 2017年 mybook. All rights reserved.
//

import UIKit

class GoodImageCell: UITableViewCell,UIScrollViewDelegate {

    @IBOutlet weak var descLabel:UILabel!
    
    @IBOutlet weak var scrollView:UIScrollView!
    
    @IBOutlet weak var pageNumLabel:UILabel!
    
    var imageUrls = [String]() {
        didSet {
            setImages()
        }
    }
    
    var imageCount:CGFloat {
        return CGFloat(imageUrls.count)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        //self.addSubview(scrollView)
        
    }
    
    func setImages() {
        
        pageNumLabel.layer.cornerRadius = pageNumLabel.ddWidth/2
        pageNumLabel.backgroundColor = UIColor.init(hexString: "757575")
        pageNumLabel.textColor = UIColor.white
        pageNumLabel.alpha = 0.6
        pageNumLabel.layer.masksToBounds = true
        pageNumLabel.text = "1/\(imageUrls.count)"
        
    
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        for i in 0..<imageUrls.count {
            
            let leftOffSet = scrollView.frame.size.width * CGFloat(i)
            let imageView = UIImageView(frame: CGRect(x: leftOffSet, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            imageView.contentMode = .scaleAspectFill
            scrollView.addSubview(imageView)
            
            let urlString = imageUrls[i]
            
            if let url = URL(string: urlString) {
                imageView.kf.setImage(with:url)
            }
            
        }
        
        scrollView.contentSize = CGSize(width: imageCount * scrollView.frame.size.width, height: scrollView.frame.size.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let currentPage = Int(scrollView.contentOffset.x/scrollView.frame.size.width) + 1
        
        pageNumLabel.text = "\(currentPage)/\(imageUrls.count)"
    }
    

}
