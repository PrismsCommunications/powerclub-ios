//
//  Gallery.swift
//  Power Club
//
//  Created by Prisms Communications on 11-04-2015.
//  Copyright © 2018 Prisms Communications. All rights reserved.
//

import UIKit
import WebKit

class GalleryVC: UIViewController {
    
    
    @IBOutlet weak var GalleryWebview: WKWebView!
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
        
        if  let id = userId {
            print(id)
            if let url =  NSURL(string: "https://testclub.prisms.in/hybrid/gallery/index.php?sid=492&fun_name=getAlbumDetailsHybrid&userId=\(id)")
            {
                print(url)
                let request = NSURLRequest(url: url as URL)
                GalleryWebview.load(request as URLRequest)
            }
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
