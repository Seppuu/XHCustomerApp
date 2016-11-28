//
//  AutoPagingView.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2016/11/28.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit

class AutoPagingView: UIView {

    var collectionView:InfiniteCollectionView!
    
    var pagingView = UIView()
    
    override func didMoveToSuperview() {
        makeUI()
    }

    func makeUI() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = InfiniteCollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.addSubview(collectionView)
        
//        let nib = UINib(nibName: cellID, bundle: nil)
//        collectionView.register(nib, forCellWithReuseIdentifier: cellID)
        
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.reloadData()
        
    }
}

extension AutoPagingView:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,InfiniteCollectionViewDataSource {
    
    // MARK: UICollectionView Methods
    func numberOfItemsInSection(_ section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func numberOfItems(collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    func cellForItemAtIndexPath(collectionView: UICollectionView, dequeueIndexPath: NSIndexPath, usableIndexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()

        cell.titleLabel.text = titlesArray[(indexPath as NSIndexPath).row]

        //设置时间
        return cell
        
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
