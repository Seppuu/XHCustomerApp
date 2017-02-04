//
//  Store.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2017/2/4.
//  Copyright © 2017年 mybook. All rights reserved.
//

import Foundation

class Store {
    
    var name:String!
    
    var id:String!
    
    var avatarUrl:String!
    
    init(name:String,id:String,avatarUrl:String) {
        
        self.name = name
        self.id = id
        self.avatarUrl = avatarUrl
    }
    
    convenience init() {
        self.init(name:"",id:"",avatarUrl:"")
    }
    
}
