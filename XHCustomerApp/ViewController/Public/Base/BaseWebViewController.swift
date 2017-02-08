//
//  BaseWebViewController.swift
//  DingDong
//
//  Created by Seppuu on 16/7/1.
//  Copyright © 2016年 seppuu. All rights reserved.
//

import UIKit
import WebKit


class BaseWebViewController: BaseViewController ,WKNavigationDelegate {
    
    var webView:WKWebView!
    var webTitle:String!
    var urlString:String!
    
    var progressView:NJKWebViewProgressView!
    
    var progressProxy:NJKWebViewProgress!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let theConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: view.bounds, configuration: theConfiguration)
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        let progressBarHeight:CGFloat = 2.0
        let navigationBarBounds = self.navigationController?.navigationBar.bounds
        let barFrame = CGRect(x: 0, y: (navigationBarBounds?.size.height)! - progressBarHeight, width: (navigationBarBounds?.size.width)!, height: progressBarHeight)
        
        
        progressView = NJKWebViewProgressView(frame: barFrame)
        progressView.autoresizingMask = [.flexibleWidth , .flexibleTopMargin]

        
        let url = URL(string: self.urlString)!
        let request = URLRequest(url: url)
        webView.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.addSubview(progressView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        progressView.removeFromSuperview()
    }
    
    //MARK:WKWebView Method
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if (keyPath == "estimatedProgress") {
            self.progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
        
    }
    
}
