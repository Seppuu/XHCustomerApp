//
//  AutoPagingView.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2016/11/28.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit

class AutoPagingView: UIView {

    var tableView:UITableView!
    
    var pagingView = UIView()
    
    override func didMoveToSuperview() {
        makeUI()
    }

    func makeUI() {
        
        tableView = UITableView(frame: self.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isPagingEnabled = true
        tableView.bounces = false
        tableView.isScrollEnabled = false
        self.addSubview(tableView)
        tableView.reloadData()
        
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(AutoPagingView.moveCell), userInfo: nil, repeats: true)
        
        timer.fire()
    }
    
    var timer:Timer!
    
    var currentRow = 0
    
    var cellHeight:CGFloat = 44
    
    func moveCell() {
        
        if currentRow > 2 {
            currentRow = 0
        }
        
//        let point = CGPoint(x: 0, y: (currentRow * cellHeight))
//        
//        tableView.setContentOffset(point, animated: true)
        let indexPath = IndexPath(row: currentRow, section: 0)
        var anime = true
        if currentRow == 0 {
            anime = false
        }
        else {
            anime = true
        }
        tableView.scrollToRow(at: indexPath, at: .top, animated: anime)
        
//        let lastIndexPath = IndexPath(row: 2, section: 0)
//        tableView.moveRow(at: indexPath, to: lastIndexPath)
        
        currentRow += 1
        
    }
   
}

extension AutoPagingView:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            cell.backgroundColor = UIColor.red
        }
        else if indexPath.row == 1{
            cell.backgroundColor = UIColor.blue
        }
        else {
            cell.backgroundColor = UIColor.orange
        }
        
        return cell
    }
    
    
    
}
