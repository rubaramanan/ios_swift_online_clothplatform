//
//  htmlarticleViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/11/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import WebKit
import ARKit
import Firebase
import FirebaseFirestore

class htmlarticleViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var htmlString = String()
    var db: Firestore!
       override func loadView() {
           let webConfiguration = WKWebViewConfiguration()
           webView = WKWebView(frame: .zero, configuration: webConfiguration)
           webView.uiDelegate = self
           webView.navigationDelegate = self
           view = webView
        //self.view.addSubview(self.contentview!)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadHTMLString( htmlString as! String, baseURL: nil)

       
    }
    

     func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
           if let serverTrust = challenge.protectionSpace.serverTrust {
               completionHandler(.useCredential, URLCredential(trust: serverTrust))
           }
       }

}
