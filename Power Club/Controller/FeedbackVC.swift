//
//  FeedbackVC.swift
//  Power Club
//
//  Created by Prisms Communications on 11-04-2015.
//  Copyright © 2018 Prisms Communications. All rights reserved.
//

import UIKit
import WebKit

class FeedbackVC: UIViewController {

    @IBOutlet weak var FeedbackWebView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url =  NSURL(string: "https://docs.google.com/forms/d/e/1FAIpQLSc4WYUzqAN260a-PauG6WQfhFSJ8wG62o4Ki2Iwb9OOaDbbFQ/viewform?entry.325730274=test&entry.821088630=9930055390")
        let request = NSURLRequest(url: url! as URL)
        FeedbackWebView.load(request as URLRequest)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.loading.startAnimating()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.loading.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
