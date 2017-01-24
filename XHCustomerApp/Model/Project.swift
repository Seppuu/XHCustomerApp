//
//  Project.swift
//  XianHui
//
//  Created by jidanyu on 16/8/22.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit

//上架产品,套餐
class Good {
    
    var title:String!
    
    var summary:String!
    
    var desc:String!
    
    var type:[String]!
    
    var id:String!
    
    var retailPrice:Int!
    
    var imageUrls:[String]!
    
    var projects:[Project]!
    
    var notes:[GoodNote]!

    
    init(id:String,title:String,desc:String,summary:String,type:[String],retailPrice:Int,imageUrls:[String],notes:[GoodNote],projects:[Project]) {
        
        self.id = id
        self.title = title
        self.desc = desc
        self.summary = summary
        self.type = type
        self.retailPrice = retailPrice
        self.imageUrls =  imageUrls
        self.notes = notes
        self.projects = projects
    }
    
    convenience init() {
        let note = GoodNote()
        let project = Project()
        self.init(id:"",title:"",desc:"",summary:"",type:[""],retailPrice:0,imageUrls:[""],notes:[note],projects:[project])
    
    }
}

//产品事项
class GoodNote {
    
    var title:String!
    
    var content:String!
    
    init(title:String,content:String) {
        
        self.title = title
        self.content = content
    }
    
    convenience init() {
        self.init(title:"",content:"")
    }
}

//项目
class Project {
    
    var title:String!
    
    var id:String!
    
    var price:Int!
    
    var amount:Int!
    
    var spec:String!
    
    init(id:String,title:String,price:Int,amount:Int,spec:String) {
        
        self.id = id
        self.title = title
        self.price = price
        self.amount = amount
        self.spec = spec
    }
    
    convenience init() {
        self.init(id:"",title:"",price:0,amount:0,spec:"无")
    }
    
}




