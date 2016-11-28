//
//  Coupon.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2016/11/28.
//  Copyright © 2016年 mybook. All rights reserved.
//

import Foundation

enum CouponType :Int {
    case typeOne = 0
    case typeTwo
    case typeThree
    case typeFour
    
    var name:String {
        
        switch self {
        case .typeOne:
            return "折扣券"
        case .typeTwo:
            return "限时券"
        case .typeThree:
            return "加项券"
        case .typeFour:
            return "其他券"
        }
        
    }
}

//优惠券
class Coupon: NSObject {

    var name = ""
    var endDate = ""
    var detail = ""
    var title = ""
    var type = CouponType.typeOne
    
}
