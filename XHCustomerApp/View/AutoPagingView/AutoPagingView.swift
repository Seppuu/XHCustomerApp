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
    
    var data = ["1","2","3","4"]
    
    var loopData:[String] {
        var arr = [String]()
        
        arr = data
        if let first = data.first {
           arr.append(first)
        }
        
        return arr
        
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
    
    var isLoopEnd = false
    
    func moveCell() {
        
        if currentRow == loopData.count - 1 {
            
            let indexPath = IndexPath(row: currentRow, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            isLoopEnd = true
            return
        }
        
        let indexPath = IndexPath(row: currentRow, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)

        currentRow += 1
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if isLoopEnd == true {
            currentRow = 0
            let indexPath0 = IndexPath(row: currentRow, section: 0)
            tableView.scrollToRow(at: indexPath0, at: .top, animated: false)
            currentRow += 1
            isLoopEnd = false
        }
        
    }
   
}

extension AutoPagingView:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loopData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        
        let l = UILabel(frame: cell.frame)
        cell.addSubview(l)
        l.text = loopData[indexPath.row]
        l.textColor = UIColor.blue
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 12)
        
        return cell
    }
    
    
    
}
