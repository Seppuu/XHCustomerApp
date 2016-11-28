//
//  CustomerCardView.swift
//  XianHui
//
//  Created by jidanyu on 16/8/22.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit

class CustomerCardView: UIView {
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var bottomContainer: UIView!
    
    @IBOutlet weak var leftTag: UILabel!
    @IBOutlet weak var middleTag: UILabel!
    @IBOutlet weak var rightTag: UILabel!
    
    @IBOutlet weak var leftTextLabel: UILabel!
    @IBOutlet weak var middleTextLabel: UILabel!
    @IBOutlet weak var rightTextLabel: UILabel!
    
    var backButtonHandler:(()->())?
    
    var leftPartTapHandler:(()->())?
    var middlePartTapHandler:(()->())?
    var rightPartTapHandler:(()->())?
    
    class func instanceFromNib() -> CustomerCardView {
        
        return UINib(nibName: "CustomerCard", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomerCardView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = avatarImageView.ddWidth/2
        avatarImageView.layer.masksToBounds = true
        
        //add line
        let frame0 = CGRect(x:screenWidth/3, y: 10, width: 1, height: bottomContainer.ddHeight - 10*2)
        let line0 = UIView(frame: frame0)
        line0.backgroundColor = UIColor ( red: 0.8539, green: 0.8539, blue: 0.8539, alpha: 1.0 )
        
        bottomContainer.addSubview(line0)
        
        let frame1 = CGRect(x: (screenWidth/3) * 2, y: 10, width: 1, height: bottomContainer.ddHeight - 10*2)
        let line1 = UIView(frame: frame1)
        line1.backgroundColor = UIColor ( red: 0.8539, green: 0.8539, blue: 0.8539, alpha: 1.0 )
        
        bottomContainer.addSubview(line1)
        
        self.isUserInteractionEnabled = true
        bottomContainer.isUserInteractionEnabled = true
        
        let leftTap = UITapGestureRecognizer(target: self, action: #selector(CustomerCardView.leftTap))
        let middleTap = UITapGestureRecognizer(target: self, action: #selector(CustomerCardView.middleTap))
        let rightTap = UITapGestureRecognizer(target: self, action: #selector(CustomerCardView.rightTap))
        
        leftTag.isUserInteractionEnabled = true
        leftTextLabel.isUserInteractionEnabled = true
        leftTag.addGestureRecognizer(leftTap)
        leftTextLabel.addGestureRecognizer(leftTap)
        
        middleTag.isUserInteractionEnabled = true
        middleTextLabel.isUserInteractionEnabled = true
        middleTag.addGestureRecognizer(middleTap)
        middleTextLabel.addGestureRecognizer(middleTap)
        
        rightTag.isUserInteractionEnabled = true
        rightTextLabel.isUserInteractionEnabled = true
        rightTag.addGestureRecognizer(rightTap)
        rightTextLabel.addGestureRecognizer(rightTap)
        
        
    }
    
    func leftTap() {
        leftPartTapHandler?()
    }
    
    func middleTap() {
        middlePartTapHandler?()
    }
    
    func rightTap() {
        rightPartTapHandler?()
    }
    
    func backImageViewTap() {
        
        backButtonHandler?()
    }
    
}


















