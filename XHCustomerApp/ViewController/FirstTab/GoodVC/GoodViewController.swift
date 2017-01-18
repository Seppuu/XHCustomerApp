//
//  GoodViewController.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2017/1/18.
//  Copyright © 2017年 mybook. All rights reserved.
//

import UIKit

class GoodViewController: UIViewController {
    
    var tableView:UITableView!
    
    var good = Good()
    
    var imageCellId = ""
    
    var projectsCellId = ""
    
    var notesCellId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        
        let cellIds = [imageCellId,
                       projectsCellId,
                       notesCellId]
        
        for id in cellIds {
            
            let nib = UINib(nibName: id, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: id)
        }
        
        
        
    }

    
}

extension GoodViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
    }
    
}


extension GoodViewController:UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return 0
        }
        else if section == 2 {
            return 1 + good.projects.count
        }
        else {
            return good.notes.count
        }
    }
}

