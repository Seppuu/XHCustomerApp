//
//  DDConfigs.swift
//  DingDong
//
//  Created by Seppuu on 16/3/2.
//  Copyright © 2016年 seppuu. All rights reserved.
//

import UIKit
import CoreLocation

let OwnSystemLoginSuccessNoti = NSNotification.Name("OwnSystemLoginSuccessNoti")

let XHAppNewUserFirstLoginNoti = NSNotification.Name("XHAppNewUserFirstLoginNoti")

var IOS10_OR_LATER:Bool {
    return (UIDevice.current.systemVersion.toFloat()! >= Float(10.0))
}

var IOS9_OR_LATER:Bool {
    return (UIDevice.current.systemVersion.toFloat()! >= Float(9.0))
}

var IOS8_OR_LATER:Bool {
    return (UIDevice.current.systemVersion.toFloat()! >= Float(8.0))
}

var IOS7_OR_LATER:Bool {
    return (UIDevice.current.systemVersion.toFloat()! >= Float(7.0))
}


let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

let DDTimeNeverReach = 12000

//let ProdBaseUrl = "http://sso.sosys.cn:8080/mybook"
//let DevBaseUrl = "http://sso.sosys.cn:8080/mybook"

let BaseUrl = "http://sso.sosys.cn:8080/mybook/rest/"
let XHPublicKey = "1addfcf4296d60f0f8e0c81cea87a099"
var DDBaseUrl:String {
    return Defaults.actualApiUrl.value!
}

var allUserIds = [String]()

//暂时的固定的token
var defaultToken = ""

///注册

//获取注册验证码
let SignInCodeUrl = BaseUrl + "registersmsgot"

//验证注册
let VerifySignInCode = BaseUrl + "registersmsverify"

//获取企业绑定信息
let GetBindingUrl = BaseUrl + "bindinginfo"

//完成企业绑定
let CompleteBingUrl = BaseUrl + "binding"


///登陆
//用户登录
let loginWithPhoneURL  = BaseUrl + "loginmobile"

//用户登出
let logOutURL          = BaseUrl + "logout"

//获取手机验证码
let getPhoneCodeUrl    = BaseUrl + "loginsmsgot"

//验证手机验证码
let verifyPhoneCodeUrl = BaseUrl + "loginsmsverify"

//更新密码
let updatePassWordUrl  = BaseUrl + "changeloginpassword"

//获取端口(企业)列表
let getCompanyListUrl  = BaseUrl + "getagentlist"

//设置当前端口(企业)
let setCurrentCompanyUrl = BaseUrl + "setdefaultagent"


//上传头像
var updateAvatarURL:String {
    return DDBaseUrl + "/rest/employee/uploadavator"
}

//完善用户资料
var updateUserInfoURL:String {
    return DDBaseUrl + "/user/index/rest?returnDataType=json&action=updateUserInfo"
}

//获取某顾客明细
var GetCustomerDetailUrl:String {
    return DDBaseUrl + "/rest/employee/getcustomerdetail"
}

//获取顾客消费记录
var GetCustomerConsumeUrl:String {
    return DDBaseUrl + "/rest/employee/getcustomerconsumelist"
}

//获取顾客预约记录
var GetCustomerSchedulesUrl:String {
    return DDBaseUrl + "/rest/employee/getcustomerschedulelist"
}

//获取顾客卡包列表
var GetCustomerCardListUrl:String {
    return DDBaseUrl + "/rest/employee/getcustomercardlist"
}

//获取顾客卡包明细 会员卡/疗程卡操作记录
var GetCustomerCardDetailUrl:String {
    return DDBaseUrl + "/rest/employee/getcustomercardlog"
}



/// 系统管理
var submitFeedBackURL:String {
    return DDBaseUrl + "/system/index/rest?returnDataType=json&action=submitFeedback"
}

///首页

//获取套餐列表
var getGoodListUrl:String {
    return  BaseUrl + "getprojectlist"
}

var getGoodDetailUrl:String {
    return  BaseUrl + "getprojectdetail"
}


























