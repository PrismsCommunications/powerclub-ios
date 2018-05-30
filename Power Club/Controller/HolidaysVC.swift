//
//  HolidaysVC.swift
//  Power Club
//
//  Created by Prisms Communications on 11-04-2015.
//  Copyright © 2018 Prisms Communications. All rights reserved.
//

import UIKit
import WebKit
import SKActivityIndicatorView


class HolidaysVC: UIViewController {

    @IBOutlet weak var HolidaysWebview: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    var User:[UserDetails]? = nil
    var userId: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SKActivityIndicator.show("Loading...")
        SKActivityIndicator.spinnerStyle(.spinningCircle)
        
        var userId: Int? = nil
        User = UserDetailsDBHandler.fetchObject()
        for i in User!
        {
            userId = Int(i.userId!)!
        }
        
        if  let id = userId{
            print(id)
            let url =  NSURL(string: "http://clubhybridmodules.prisms.in/holidays/\(id)/492")
            let request = NSURLRequest(url: url! as URL)
            HolidaysWebview.load(request as URLRequest)
            SKActivityIndicator.dismiss()
        }
    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SKActivityIndicator.dismiss()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
