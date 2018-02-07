//
//  YourProfileVC.swift
//  
//
//  Created by Prisms Communications on 11-04-2015.
//

import UIKit
import WebKit

class YourProfileVC: UIViewController {

    @IBOutlet weak var profileWebview: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    var User:[UserDetails]? = nil
    var userId: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var userId: Int? = nil
        User = UserDetailsDBHandler.fetchObject()
        for i in User!
        {
            userId = Int(i.userId!)!
        }
        
        if  let id = userId{
            print(id)
            let url =  NSURL(string: "http://clubhybridmodules.prisms.in/memberdetails/\(id)/492")
            let request = NSURLRequest(url: url! as URL)
            profileWebview.load(request as URLRequest)
        }
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
