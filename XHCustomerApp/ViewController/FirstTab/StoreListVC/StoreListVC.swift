//
//  StoreListVC.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2017/2/4.
//  Copyright © 2017年 mybook. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON

class StoreListVC: UIViewController {
    
    var tableView:UITableView!
    
    var storeList = [Store]()
    
    var goodCellId = "ContactsCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
    }

   
    func setTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib1 = UINib(nibName: goodCellId, bundle: nil)
        tableView.register(nib1, forCellReuseIdentifier: goodCellId)
        
        //getList()
        
        makeDataForATime()
    }
    
    func getList() {
        
        NetworkManager.sharedManager.getStoreListWith { (success, json, error) in
            
            if success == true {
                self.makeData(json: json!)
            }
            else {
                
            }
        }
        
    }
    
    func makeData(json:JSON) {
        
        if let datas = json.array {
            
            for data in datas {
                
                let store = Store()
                
                if let name = data["name"].string {
                    store.name = name
                }

                if let avatarUrl = data["avatarUrl"].string {
                    store.avatarUrl = avatarUrl
                }
                
                storeList.append(store)
            }
            
            tableView.reloadData()
            
        }
        
    }
    
    func makeDataForATime() {
        
        for _ in 0...5 {
            
            let store = Store()
            store.name = "店名"
            storeList.append(store)
        }
        
        tableView.reloadData()
        
    }
}

extension StoreListVC:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return storeList.count
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: goodCellId, for: indexPath) as! ContactsCell
        
        let store = storeList[indexPath.row]
        
        cell.nameLabel.text = store.name
        if let url = URL(string: store.avatarUrl) {
            cell.avatarImageView.kf.setImage(with: url)
        }
        cell.avatarImageView.contentMode = .scaleAspectFill
        
        cell.avatarImageView.backgroundColor = UIColor.ddViewBackGroundColor()
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
}
