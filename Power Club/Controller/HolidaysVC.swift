//
//  HolidaysVC.swift
//  Power Club
//
//  Created by Prisms Communications on 11-04-2015.
//  Copyright © 2018 Prisms Communications. All rights reserved.
//

import UIKit
import WebKit

class HolidaysVC: UIViewController {

    @IBOutlet weak var HolidaysWebview: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url =  URL(string: "http://clubhybridmodules.prisms.in/holidays/200/492")
        let request = URLRequest(url: url!)
        
        HolidaysWebview.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
