//
//  GoodDetailViewController.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2017/1/19.
//  Copyright © 2017年 mybook. All rights reserved.
//

import UIKit

class GoodDetailViewController: UIViewController {

    var tableView:UITableView!
    
    var good = Good()
    
    var goodProfileCellId = "GoodProfileCell"
    
    var projectsCellId = "GoodDetailCell"
    
    var notesCellId = "GoodNoteCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "图文详情"
        view.backgroundColor = UIColor.ddViewBackGroundColor()
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        let cellIds = [goodProfileCellId,
                       projectsCellId,
                       notesCellId]
        
        for id in cellIds {
            
            let nib = UINib(nibName: id, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: id)
        }
        
    }

}

extension GoodDetailViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: goodProfileCellId, for: indexPath) as! GoodProfileCell
            
            cell.textView.text = good.desc
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: projectsCellId, for: indexPath) as! GoodDetailCell
            let p = good.projects[indexPath.row]
            cell.nameLabel.text = p.title
            cell.countLabel.text = String(p.amount) + p.spec
            cell.priceLaebl.text = String(p.price) + "元"
            
            if p.amount == 0 {
                cell.countLabel.text = p.spec
            }
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: notesCellId, for: indexPath) as! GoodNoteCell
            
            let n = good.notes[indexPath.row]
            cell.titleLabel.text = n.title
            cell.descLabel.text = n.content
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "产品介绍"
        }
        if section == 1 {
            return "套餐"
        }
        else {
            return "购买须知"
        }
    }
    
}


extension GoodDetailViewController:UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        

        if indexPath.section == 1 {
            return 25
        }
        else {
            return UITableViewAutomaticDimension
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return good.projects.count
        }
        else {
            return good.notes.count
        }
    }
    
}
