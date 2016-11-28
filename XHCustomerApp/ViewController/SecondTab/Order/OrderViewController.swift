//
//  OrderViewController.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2016/11/25.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit
import SnapKit

class OrderViewController: UIViewController {

    var pageMenu : CAPSPageMenu?
    
    var pageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单"
        view.backgroundColor = UIColor.ddViewBackGroundColor()
        setSubView()
        setNavBar()
    }
    
    func setNavBar() {
        
        let rightBarItem = UIBarButtonItem(title: "评价", style: UIBarButtonItemStyle.plain, target: self, action: #selector(OrderViewController.rightTap))
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    
    func rightTap() {
        
        let vc = CommentVC()
        vc.title = "评价"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    let pageMenuParameters: [CAPSPageMenuOption] = [
        .menuItemSeparatorWidth(0.0),
        .scrollMenuBackgroundColor(UIColor.white),
        .viewBackgroundColor(UIColor(red: 254.9/255.0, green: 251.4/255.0, blue: 243.7/255.0, alpha: 1.0)),
        .bottomMenuHairlineColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 0.1)),
        .selectionIndicatorColor(UIColor(red: 96.4/255.0, green: 80.8/255.0, blue: 81.2/255.0, alpha: 1.0)),
        .menuMargin(20.0),
        .menuHeight(40.0),
        .selectedMenuItemLabelColor(UIColor(red: 96.4/255.0, green: 80.8/255.0, blue: 81.2/255.0, alpha: 1.0)),
        .unselectedMenuItemLabelColor(UIColor(red: 116.7/255.0, green: 96.1/255.0, blue: 97.2/255.0, alpha: 1.0)),
        .menuItemFont(UIFont(name: "HelveticaNeue-Medium", size: 14.0)!),
        .useMenuLikeSegmentedControl(true),
        .menuItemSeparatorRoundEdges(false),
        .selectionIndicatorHeight(2.0),
        .menuItemSeparatorPercentageHeight(0.1)
    ]
    
    func setSubView() {
        
        // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        let controller1 = OrderListVC()
        
        controller1.parentNavigationController = self.navigationController
        controller1.parentVC = self
        controller1.title = "全部"
        controllerArray.append(controller1)
        
        let controller2 = OrderListVC()
        controller2.title = "未评价"
        controller2.parentNavigationController = self.navigationController
        controller2.parentVC = self
        controllerArray.append(controller2)
        
        let controller3 = OrderListVC()
        controller3.title = "待抽奖"
        controller3.parentNavigationController = self.navigationController
        controller3.parentVC = self
        controllerArray.append(controller3)
        
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64), pageMenuOptions: pageMenuParameters)
        
        // Optional delegate
        pageMenu!.controllerScrollView.isScrollEnabled = true
        
        pageMenu!.moveToPage(pageIndex)
        
        
        self.view.addSubview(pageMenu!.view)
        
    }

}
