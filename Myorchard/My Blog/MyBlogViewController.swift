//
//  MyBlogViewController.swift
//  Myorchard
//
//  Created by PewPew on 7/5/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit
import WebKit

class MyBlogViewController: UIViewController, WKUIDelegate {
    
        var webView: WKWebView!
        
        override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let myURL = URL(string:"https://pewpewpudog.wixsite.com/myorchard")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
    
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


