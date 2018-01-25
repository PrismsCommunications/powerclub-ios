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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url =  URL(string: "http://clubhybridmodules.prisms.in/memberdetails/200/492")
        
        let request = URLRequest(url: url!)
        
        profileWebview.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
