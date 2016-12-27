//
//  BindViewController.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2016/12/26.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

class BindViewController: BaseTableViewController {

    var agentId:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            
            self.getData()
        })
        
        tableView.mj_header.beginRefreshing()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    func setNavBar() {
        
        let rightBar = UIBarButtonItem(title: "确定", style: .plain, target: self, action: #selector(BindViewController.confirm))
        navigationItem.rightBarButtonItem = rightBar
    }
    
    func confirm() {
        
        let hud = showHudWith(self.view, animated: true, mode: .indeterminate, text: "")
        NetworkManager.sharedManager.completeBingWith(Defaults.currentAccountName.value!, usertype: .Customer, agentId: 1) { (success, json, error) in
            
            var text = ""
            if success == true {
                text = "绑定成功"
                self.bindSuccess()
                
            }
            else {
                text = error!
            }
            
            hud.mode = .text
            hud.labelText = text
            hud.hide(true, afterDelay: 2.0)
            
        }
        
    }
    
    func bindSuccess() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func getData() {
        
        NetworkManager.sharedManager.getBingInfoWith(Defaults.currentAccountName.value!, usertype: .Customer, agentId: 1) { (success, json, error) in
            if success == true {
                self.setNavBar()
                self.makeData(json!)
                
            }
            else {
                
            }
            
        }
        
    }
    
    
    var agentName = ""
    
    var displayName = ""
    
    var orgName = ""
    
    func makeData(_ data:JSON) {
        
        let section0 = BaseTableViewModelList()
        let section1 = BaseTableViewModelList()
        
        
        if let agentName = data["agent_name"].string {
            self.agentName = agentName
        }
        
        if let displayName = data["display_name"].string {
            self.displayName = displayName
        }
        
        if let orgName = data["org_name"].string {
            self.orgName = orgName
        }
        
        if let vipCards = data["vipcard_list"].array {
            
            for card in vipCards {
                //会员卡
                let model = BaseTableViewModel()
                if let fullName = card["card_name"].string {
                    model.name = fullName
                }
                
                if let amount = card["amount"].string {
                    model.desc = "余"  + amount
                }
                
                if let cardNum = card["card_num"].string {
                    model.num = cardNum
                }
                
                model.hasList = false
                section0.listName = "会员卡"
                section0.list.append(model)
            }
            
        }
        
        if let coursecardList = data["coursecard_list"].array {
            
            for list in coursecardList {
                
                //疗程卡
                let model = BaseTableViewModel()
                if let fullName = list["card_name"].string {
                    model.name = fullName
                }
                
                if let amount = list["amount"].string {
                    model.desc = "余"  + amount
                }
                
//                if let project_list = data["project_list"].array {
//                    for p in project_list {
//                        var times = 0
//                        times += p["times"].string!.toInt()!
//                        model.desc = String(times) + "次"
//                    }
//                    
//                }
                
                model.hasList = false
                section1.listName = "疗程卡"
                section1.list.append(model)
            }
        }
        
        //如果没有会员卡或者疗程卡,显示提示
        
        if section0.list.count == 0 {
            let model = BaseTableViewModel()
            model.hasList = false
            model.name = "暂无"
            model.num = ""
            section0.listName = "会员卡"
            section0.list.append(model)
        }
        
        if section1.list.count == 0 {
            let model = BaseTableViewModel()
            model.hasList = false
            model.name = "暂无"
            model.num = ""
            
            section1.listName = "疗程卡"
            section1.list.append(model)
        }
        
        

        self.listArray = [section0,section1]
        self.tableView.reloadData()
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = self.listArray[(indexPath as NSIndexPath).section].list[(indexPath as NSIndexPath).row]
        
        let vc = CustomerCardDetailVC()
        vc.cardNum = model.num
        vc.title = model.name
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cellId = "CustomerLargeCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? CustomerLargeCell
            if cell == nil {
                let nib = UINib(nibName: cellId, bundle: nil)
                tableView.register(nib, forCellReuseIdentifier: cellId)
                cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? CustomerLargeCell
            }
            cell!.selectionStyle = .none
//            if let url = URL(string:profileModel.avatarUrl)  {
//                cell!.avatarImageView.kf.setImage(with: url)
//            }
            cell!.nameLabel.text = self.displayName
            cell!.vipLabel.text = self.agentName
            cell!.numberLabel.text = self.orgName
            
            
            return cell!
        }
        else {
            
            let cell = super.tableView(tableView, cellForRowAt: indexPath)
            cell.accessoryType = .none
            cell.accessoryView = nil
            return cell
        }
        
    
    }
    
}
