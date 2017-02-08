//
//  SignInViewController.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2016/12/23.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var topContainer: UIView!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var CodeLabel: UILabel!
    
    @IBOutlet weak var PasswordTextField: UITextField!

    @IBOutlet weak var CodeTextField: UITextField!
    
    @IBOutlet weak var SignInButton: UIButton!
    
    var phone:String {
        return phoneTextField.text!
    }
    
    var passWord:String {
        return PasswordTextField.text!
    }
    
    var code:String {
        return CodeTextField.text!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.getSmsCode))
        CodeLabel.isUserInteractionEnabled = true
        CodeLabel.addGestureRecognizer(tap)
    }
    
    func setNavBar() {
        
        let leftNavBar = UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(SignInViewController.back))
        
        self.navigationItem.leftBarButtonItem = leftNavBar
        
    }
    
    func back() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    func getSmsCode() {
        
        if phone.isPhoneNumber() == false {
            
            DDAlert.alert(title: "提示", message: "请填写正确的手机号码", dismissTitle: "OK", inViewController: self, withDismissAction: nil)
            
            return
        }
        
        CodeLabel.text = "发送中..."
        
        NetworkManager.sharedManager.getSignInCode(phone, usertype: .Customer) { (success, json, error) in
            
            if success == true {
                self.CodeLabel.text = "已发送"
            }
            else {
                let hud = showHudWith(self.view, animated: true, mode: .text, text: "发送失败")
                hud.hide(true, afterDelay: 1.0)
                self.CodeLabel.text = "发送验证码"
            }
            
        }
        
    }
    
    @IBAction func SignInTap(_ sender: UIButton) {
        
        var msg = ""
        
        if code == "" {
            msg = "请填写验证码"
        }
        else if passWord == "" {
            msg = "请填写密码"
        }
        else if phone == "" {
            msg = "请填写手机号码"
        }
        else {
            
        }
        
        if msg != "" {
            
            DDAlert.alert(title: "提示", message: msg, dismissTitle: "OK", inViewController: self, withDismissAction: nil)
            
            return
        }
        
        signIn()
    }
    
    
    func signIn() {
        
        let hud = showHudWith(self.view, animated: true, mode: .indeterminate, text: "")
        
        NetworkManager.sharedManager.verifySignInCode(phone, usertype: .Customer, code: code) { (success, json, error) in
            
            if success == true {
                
                self.updatePassWord()
                
            }
            else {
                hud.labelText = error
                
            }
            
            hud.hide(true, afterDelay: 1.0)
            
        }
        
        
    }
    
    
    func updatePassWord() {
        
        let hud = showHudWith(self.view, animated: true, mode: .indeterminate, text: "")
        
        NetworkManager.sharedManager.updatePassWordWith(phone, usertype: .Customer, passWord: passWord) { (success, json, error) in
            
            if success == true {
                
                self.back()
            }
            else {
                hud.labelText = error
                
            }
            
            hud.hide(true, afterDelay: 1.0)
        }
        
    }

    
    
}
