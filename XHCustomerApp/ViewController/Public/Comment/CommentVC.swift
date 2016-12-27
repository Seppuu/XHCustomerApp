//
//  CommentVC.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2016/11/25.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit

class CommentVC: UIViewController {
    
    var tableView:UITableView!
    
    var starCell = "CommentStarCell"
    
    var tagCell  = "StarWithTagCell"
    
    var tag0 = ["技术好","环境好","价格合理","顾问不错"]
    
    var tag1 = ["技术好差","环境好差","价格坑","顾问搓"]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.ddViewBackGroundColor()
        makeTags()
        setTableView()
        setNavBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setNavBarItem() {
        
        let rightBarItem = UIBarButtonItem(title: "提交", style: .done, target: self, action: #selector(CommentVC.submit))
        self.navigationItem.rightBarButtonItem = rightBarItem
        
    }
    
    func submit() {
        //TODO:submit
        let hud = showHudWith(self.view, animated: true, mode: .indeterminate, text: "")
        
        hud.hide(true)
        showAlert()
        
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: "评价成功", message: "每次评价之后,参与抽奖,有机会赢取免单等优惠!", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "下次吧", style: .cancel, handler: nil)
        
        let confirmAction = UIAlertAction(title: "去抽奖", style: .default) { (action) in
            
            let webVC = BaseWebViewController()
            webVC.urlString = "https://kaifanfr.github.io/Lottery/"
            self.navigationController?.pushViewController(webVC, animated: true)
            
        }
        
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    var tags0 = [Tag]()
    
    var tags1 = [Tag]()
    
    func makeTags() {
        
        for name in tag0 {
            let tag = Tag()
            tag.name = name
            tags0.append(tag)
        }
        
        for name in tag1 {
            let tag = Tag()
            tag.name = name
            tags1.append(tag)
        }
        
    }
    
    
    func setTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        let nib0 = UINib(nibName: starCell, bundle: nil)
        tableView.register(nib0, forCellReuseIdentifier: starCell)
        
        let nib1 = UINib(nibName: tagCell, bundle: nil)
        tableView.register(nib1, forCellReuseIdentifier: tagCell)
        
    }

    

}

extension CommentVC:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 186
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: starCell, for: indexPath) as! CommentStarCell
            cell.selectionStyle = .none
            
            let user = User.currentUser()
            
            if let url = URL(string: (user?.avatarURL)!) {
                cell.avatarView.kf.setImage(with: url)
            }
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: tagCell, for: indexPath) as! StarWithTagCell
            cell.selectionStyle = .none
            cell.tagList = tags0
            
            cell.starView.didTouchCosmos = {
                (rating) in
                
                if rating >= 3 {
                    cell.tagList = self.tags0
                }
                else {
                    cell.tagList = self.tags1
                }
                
            }
            
            
            return cell
            
        }
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
}


