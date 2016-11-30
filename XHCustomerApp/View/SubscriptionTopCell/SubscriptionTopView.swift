//
//  SubscriptionTopView.swift
//  DingDong
//
//  Created by Seppuu on 16/5/30.
//  Copyright © 2016年 seppuu. All rights reserved.
//

import UIKit
import SwiftyJSON

class SubscriptionTopView: UIView,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellID = "SubscriptionDetailCell"
    
    var listOfAuthor = [JSON]()
    
   // var authorCellTapHandler:((_ authorID:String,_ authorName:String)->())?
    
    class func instanceFromNib() -> SubscriptionTopView {
        
        return UINib(nibName: "SubscriptionTopView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SubscriptionTopView
    }
    
    override func didMoveToWindow() {
        super.didMoveToSuperview()
        
        setCollectionview()
        
    }
    
    func setCollectionview() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        let nib = UINib(nibName: cellID, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellID)
        
        collectionView.reloadData()
        
    }

    // MARK: UICollectionView Methods
    
    func numberOfItemsInSection(section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SubscriptionDetailCell
        
        cell.avatarView.backgroundColor = UIColor.ddViewBackGroundColor()
        
        let text = "项目分类" + String(indexPath.row + 1)
        cell.nameLabel.text = text
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}



