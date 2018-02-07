//
//  NotificationVC.swift
//  Power Club
//
//  Created by Prisms Communications on 11-04-2015.
//  Copyright © 2018 Prisms Communications. All rights reserved.
//

import UIKit
import WebKit

class NotificationVC: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var notificationWebview: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    var User:[UserDetails]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var userId: Int? = nil
        User = UserDetailsDBHandler.fetchObject()
        for i in User!
        {
            userId = Int(i.userId!)!
        }
        
        if  let id = userId {
            print(id)
            let url =  NSURL(string: "http://clubhybridmodules.prisms.in/notifications/\(id)/492")
            let request = NSURLRequest(url: url! as URL)
            notificationWebview.load(request as URLRequest)
        }
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.loading.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.loading.stopAnimating()
        self.loading.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
