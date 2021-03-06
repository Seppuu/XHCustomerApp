//
//  NetworkManager.swift
//  DingDong
//
//  Created by Seppuu on 16/6/3.
//  Copyright © 2016年 seppuu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift
import SwiftDate

enum  VerifyCodeType: String {
    
    case sms = "sms"
    case voice = "voice"
    
}

enum UserLoginType:String {
    case Customer = "customer"
    case Employee = "employee"
}

enum PhoneCodeType:String {
    case sms = "sms"
    case voice = "voice"
}


///网络请求基本回调
typealias DDResultHandler = (_ success:Bool,_ json:JSON?,_ error:String?) -> Void

public typealias JSONDictionary = [String: Any]


class NetworkManager {
    
    static var sharedManager = NetworkManager()
    
    var baseDict: JSONDictionary = [
        "token":Defaults.userToken.value!,
        "ssid" :Defaults.userSSID.value!
    ]
    
    //MARK:用户
    
    //注册验证码
    func getSignInCode(_ phone:String,usertype:UserLoginType,completion:@escaping DDResultHandler) {
        
        
        let sign = (phone + "-" + usertype.rawValue + "-" + Date.currentDateString() + "-" + XHPublicKey).md5()
        
        let dict:JSONDictionary = [
            "mobile":phone,
            "type":usertype.rawValue,
            "sms_type":"sms",
            "sign":sign
        ]
        
        let urlString = SignInCodeUrl
        
        baseRequestWith(urlString, dict: dict, completion: completion)
        
    }
    
    //验证注册
    func verifySignInCode(_ phone:String,usertype:UserLoginType,code:String,completion:@escaping DDResultHandler) {
        
        
        let sign = (phone + "-" + usertype.rawValue + "-" + code + "-" + Date.currentDateString() + "-" + XHPublicKey).md5()
        
        let dict:JSONDictionary = [
            "mobile":phone,
            "type":usertype.rawValue,
            "sms_code":code,
            "sign":sign
        ]
        
        let urlString = VerifySignInCode
        
        baseRequestWith(urlString, dict: dict, completion: completion)
        
    }
    
    //获取绑定信息
    func getBingInfoWith(_ phone:String,usertype:UserLoginType,agentId:Int,completion:@escaping DDResultHandler) {
        
        
        let sign = (phone + "-" + usertype.rawValue + "-" + String(agentId) + "-" + Date.currentDateString() + "-" + XHPublicKey).md5()
        
        let dict:JSONDictionary = [
            "mobile":phone,
            "type":usertype.rawValue,
            "agent_id":agentId,
            "sign":sign
        ]
        
        let urlString = GetBindingUrl
        
        baseRequestWith(urlString, dict: dict, completion: completion)
        
    }
    
    //完成绑定
    func completeBingWith(_ phone:String,usertype:UserLoginType,agentId:Int,completion:@escaping DDResultHandler) {
        
        
        let sign = (phone + "-" + usertype.rawValue + "-" + String(agentId) + "-" + Date.currentDateString() + "-" + XHPublicKey).md5()
        
        let dict:JSONDictionary = [
            "mobile":phone,
            "type":usertype.rawValue,
            "agent_id":agentId,
            "sign":sign
        ]
        
        let urlString = CompleteBingUrl
        
        baseRequestWith(urlString, dict: dict, completion: completion)
        
    }
    
    
    
    //login
    func loginWith(_ mobile:String,passWord:String,usertype:UserLoginType,completion:@escaping DDResultHandler) {
        
        var dict:JSONDictionary!
        
        dict = [
                "mobile":mobile,
                "password":passWord,
                "type":usertype.rawValue
            ]
        
        let urlString = loginWithPhoneURL
        
        baseRequestWith(urlString, dict: dict, completion: completion)
    }
    
    //登出
    func userLogOut(_ completion:@escaping DDResultHandler) {
        
        //let newDict = generatePostDictWithBaseDictOr(nil)
        
        let dict:JSONDictionary = [
            "token":Defaults.userToken.value!
        ]
        
        let urlString = logOutURL
        
        baseRequestWith(urlString, dict: dict, completion: completion)
    }
    
    
    //获取手机验证码
    func getPhoneCodeWith(_ mobile:String,usertype:UserLoginType,codeType:PhoneCodeType,completion:@escaping DDResultHandler) {
        
        let dict:JSONDictionary = [
            "mobile":mobile,
            "type":usertype.rawValue,
            "sms_type":codeType.rawValue
        ]
        
        let urlString = getPhoneCodeUrl
        
        baseRequestWith(urlString, dict: dict, completion: completion)
        
    }
    
    
    
    //验证手机验证码
    func verifyPhoneCodeWith(_ mobile:String,usertype:UserLoginType,code:String,completion:@escaping DDResultHandler) {
        
        let dict:JSONDictionary = [
            "mobile":mobile,
            "type":usertype.rawValue,
            "sms_code":code
        ]
        
        let urlString = verifyPhoneCodeUrl
        
        baseRequestWith(urlString, dict: dict, completion: completion)
        
    }
    
    //更新密码
    func updatePassWordWith(_ userName:String,usertype:UserLoginType,passWord:String,completion:@escaping DDResultHandler) {
        
        
        let sign = (userName + "-" + usertype.rawValue + "-" + passWord + "-" + Date.currentDateString() + "-" + XHPublicKey).md5()
        
        let dict:JSONDictionary = [
            "username":userName,
            "type":usertype.rawValue,
            "password":passWord,
            "sign":sign
        ]
        
        let urlString = updatePassWordUrl
        
        baseRequestWith(urlString, dict: dict, completion: completion)
        
    }
    
    
    //获取企业列表
    func getCompanyListWith(_ userName:String,usertype:UserLoginType,completion:@escaping DDResultHandler) {

        let sign = (userName + "-" + usertype.rawValue + "-" + Date.currentDateString() + "-" + XHPublicKey).md5()
        
        let dict:JSONDictionary = [
            "username":userName,
            "type":usertype.rawValue,
            "sign":sign
        ]
        
        let urlString = getCompanyListUrl
        
        baseRequestWith(urlString, dict: dict, completion: completion)
        
    }
    
    //设置当前企业
    func setCurrentCompanyWith(_ userName:String,usertype:UserLoginType,agentId:Int,completion:@escaping DDResultHandler) {
        
        let sign = (userName + "-" + usertype.rawValue + "-" + String(agentId) + "-" + Date.currentDateString() + "-" + XHPublicKey).md5()
        
        let dict:JSONDictionary = [
            "username":userName,
            "type":usertype.rawValue,
            "agent_id":agentId,
            "sign":sign
        ]
        
        let urlString = setCurrentCompanyUrl
        
        baseRequestWith(urlString, dict: dict, completion: completion)
        
        
    }
    
    func updateUserAvatarWith(_ avatar:UIImage,completion:@escaping DDResultHandler) {
        
        let dict = [
            "token":Defaults.userToken.value!
        ]
        
        
        let urlString = updateAvatarURL
        
        let zipData = UIImageJPEGRepresentation(avatar, 0.1)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            //json dict
            for (key, value) in dict {
                let str = String(value)
                multipartFormData.append(str!.data(using: String.Encoding.utf8)!, withName: key)
              
            }
            
            //add iamge data if need
            if zipData != nil {
                multipartFormData.append(zipData!, withName: "avator", fileName: "avator.jpg", mimeType: "image/jpg")
                
                
            }
            
            }, to: urlString) { (encodingResult) in
                
                switch encodingResult {
                case .success(let upload, _, _ ):
                    
                    upload.responseJSON(completionHandler: { (response) in
                        
                        let json = JSON(response.result.value!)
                        
                        if json["status"].string == "ok" {
                            let avatarUrlString = json["data"]
                            completion(true, avatarUrlString,nil)
                        }
                        else {
                            let msg = self.getErrorMsgFrom(json)
                            completion(false, nil,msg)
                        }
                        
                    })
                    
                    
                case .failure(let encodingError):
                    print("Failure")
                    print(encodingError)
                    completion(false, nil,"请求失败")
                }

                
        }
        
        
        
    }
    
    //完善用户信息
    func updateUserInfo(with firstName:String,lastName:String,avatarData:Data?,completion:@escaping DDResultHandler) {
        
        let dict:JSONDictionary = [
            "first_name":firstName,
            "last_name" :lastName
        ]
        
        let newDict = generatePostDictWithBaseDictOr(dict)
        
        let urlString = updateUserInfoURL
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            //json dict
            for (key, value) in newDict {
                if let str = value as? String {
                    multipartFormData.append(str.data(using: String.Encoding.utf8)!, withName: key)
                }
                
                
            }
            
            //add iamge data if need
            if avatarData != nil {
                multipartFormData.append(avatarData!, withName: "avator", fileName: "avator.jpg", mimeType: "image/jpg")
                
                
            }
            
            
        }, to: urlString) { (encodingResult) in
            
            switch encodingResult {
            case .success(let upload, _, _ ):
                
                upload.responseJSON(completionHandler: { (response) in
                    
                    let json = JSON(response.result.value!)
                    
                    if json["status"].int == 1 {
                        let dataInfo = json["dataInfo"]
                        completion(true, dataInfo,nil)
                    }
                    else {
                        let msg = self.getErrorMsgFrom(json)
                        completion(false, nil,msg)
                    }
                    
                })
                
                
            case .failure(let encodingError):
                print("Failure")
                print(encodingError)
                completion(false, nil,"请求失败")
            }
        }


        
    }
    

}


//MARK:店铺新增,切换.
extension NetworkManager {
    //店铺列表
    func getStoreListWith(_ completion:@escaping DDResultHandler) {
        
        let urlString = ""
        
        let sign = (Date.currentDateString() + "-" + XHPublicKey).md5()
        
        let dict:JSONDictionary = [
            "sign":sign
        ]
        
        baseRequestWith(urlString, dict: dict, completion: completion)
    }
    
    
    
}



extension NetworkManager {
    
    func getGoodListWith(_ pageSize:Int,pageNumber:Int,completion:@escaping DDResultHandler) {
        let urlString = getGoodListUrl
        
        let sign = (Date.currentDateString() + "-" + XHPublicKey).md5()
        
        let dict:JSONDictionary = [
            "sign":sign,
            "pageSize":pageSize,
            "pageNumber":pageNumber
        ]
        
        baseRequestWith(urlString, dict: dict, completion: completion)
    }
    
    func getGoodDetailWith(_ agentId:String,goodId:String,completion:@escaping DDResultHandler) {
        
        let urlString = getGoodDetailUrl
        
        let sign = (agentId + "-" + goodId + "-" + XHPublicKey).md5()
        
        let dict:JSONDictionary = [
            "sign":sign,
            "project_id":goodId,
            "agent_id":agentId
        ]
        
        baseRequestWith(urlString, dict: dict, completion: completion)
        
    }
    
    
    //详细的消费记录
    func getCustomerConsumeListWith(_ id:Int,pageSize:Int,pageNumber:Int,completion:@escaping DDResultHandler) {
        
        let urlString = GetCustomerConsumeUrl
        
        let dict:JSONDictionary = [
            "token":Defaults.userToken.value!,
            "customer_id":id,
            "pageSize":pageSize,
            "pageNumber":pageNumber
        ]
        
        baseRequestWith(urlString, dict: dict, completion: completion)
        
    }

    //获取顾客卡包列表
    func getCustomerCardListWith(_ customerId:Int,completion:@escaping DDResultHandler) {
        
        let urlString = GetCustomerCardListUrl
        
        let dict:JSONDictionary = [
            "token":Defaults.userToken.value!,
            "customer_id":customerId
        ]
        
        baseRequestWith(urlString, dict: dict, completion: completion)
    }
    
    //获取顾客卡包明细
    func getCustomerCardDetailWith(_ cardNum:String,completion:@escaping DDResultHandler) {
        
        let urlString = GetCustomerCardDetailUrl
        
        let dict:JSONDictionary = [
            "token":Defaults.userToken.value!,
            "card_num":cardNum
        ]
        
        baseRequestWith(urlString, dict: dict, completion: completion)
    }
    
}

//MARK:系统管理
extension NetworkManager {
    
    //发送反馈
    func submitFeedback(with content:String, completion:@escaping DDResultHandler) {
        
        let urlString = submitFeedBackURL
        let jsonDict:JSONDictionary = [
            "content":content
        ]
        let dict = generatePostDictWithBaseDictOr(jsonDict)

        baseRequestWith(urlString, dict: dict, completion: completion)
    }
}


//MAKR:基本请求方法
extension NetworkManager {
    
    fileprivate func addSignTo( _ dict:JSONDictionary) -> JSONDictionary {
        
        let keys = dict.keys
        
        let sortedKeys = keys.sorted { (value1, value2) -> Bool in
            return value1 < value2
        }
        
        var parameter = ""
        
        for key in sortedKeys {
            parameter += key + "\(dict[key]!)"
        }
        
        let md5 = parameter.md5
        
        var newDict = dict
        
        newDict["sign"] = md5
        
        return newDict
    }
    
    fileprivate func getErrorMsgFrom(_ json:JSON) -> String {
        var msg = ""
        msg = json["message"].string!
        
        return msg
    }
    
    //生成post参数.
    fileprivate func generatePostDictWithBaseDictOr(_ dict:JSONDictionary?) -> JSONDictionary {
        
        var d = JSONDictionary()
        
        for (key,value) in baseDict {
            
            d[key] = value
            
        }
        if dict != nil {
            
            for (key,value) in dict! {
                
                d[key] = value
                
            }
        }
        else {
            //不需要其他参数了.
        }
        
        return addSignTo(d)
        
    }
    //REQUEST
    //基本请求,返回 status dataInfo errorMsg
    fileprivate func baseRequestWith(_ urlString:String,dict:JSONDictionary,completion:@escaping DDResultHandler) {
        
        let parameters:Parameters = dict
        
        Alamofire.request(urlString, method: .post, parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(response.result.value!)
                    if let status = json["status"].string {
                        if status == "ok" {
                            let dataInfo = json["data"]
                            completion(true,dataInfo,nil)
                            
                        }
                        else {
                            let msg = self.getErrorMsgFrom(json)
                            let dataInfo = json["data"]
                            completion(false, dataInfo, msg)
                        }
                    }
                    
                case .failure(let error):
                    completion(false, nil, error.localizedDescription)
                    
                }
        }

    }
    
    
    //UPLOAD
    
}


