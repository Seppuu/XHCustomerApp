//
//  Order.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2016/11/25.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit

enum OrderStatus:Int {
    case wait = 0
    case servering
    case perchase
    case comment
    
    var status:String {
        switch self {
        case .wait:
            return "未开始"
        case .servering:
            return "进行中"
        case .perchase:
            return "待付款"
        case .comment:
            return "待评价"
        default:
            break;
        }
    }
}

class Order: NSObject {
    
    var status = OrderStatus.wait
    var name = ""
    var detailList = [OrderDetail]()
    
    var customerName = ""
    var orgName = ""//门店
    var goodNo = ""
    var goodName = ""
    var bedName = ""
    var employee = ""
    
    var startTime = ""
    
    var numbers = ""
    var isProd = false
    
    
}

class OrderDetail: NSObject {
    
    var name = ""
    var count = 0
}
