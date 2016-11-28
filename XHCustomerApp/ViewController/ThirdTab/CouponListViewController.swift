//
//  CouponListViewController.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2016/11/28.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit

class CouponListViewController: UIViewController {
    
    var tableView:UITableView!
    
    var cellId = "CouponCell"

    var couponList = [Coupon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ddViewBackGroundColor()
        setTableView()
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: cellId, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        
    }

    
    func setNavBar() {
        let rightBar = UIBarButtonItem(title: "添加", style: .plain, target: self, action: #selector(CouponListViewController.addCoupon))
        navigationItem.rightBarButtonItem = rightBar
        
    }
    
    func addCoupon() {
        
    }
    
    func getData() {
        
        for _ in 0...3 {
            let c = Coupon()
            c.name = "折扣券"
            c.endDate = "有效日期至2017.01.05"
            c.detail = "仅限18652805163用户使用"
            c.title = "7折"
            couponList.append(c)
        }
        
        tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CouponListViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return couponList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CouponCell
        cell.selectionStyle = .none
        let c = couponList[indexPath.row]
        cell.nameLabel.text = c.name
        cell.middleLabel.text = c.endDate
        cell.bottomLabel.text = c.detail
        cell.rightLabel.text = c.title
        
        return cell
    }
    
    
}
