//
//  NotificationVC.swift
//  Power Club
//
//  Created by Prisms Communications on 11-04-2015.
//  Copyright © 2018 Prisms Communications. All rights reserved.
//

import UIKit
import WebKit

class NotificationVC: UIViewController {

    @IBOutlet weak var notificationWebview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url =  URL(string: "http://clubhybridmodules.prisms.in/notifications/200/492")
        let request = URLRequest(url: url!)
        
        notificationWebview.load(request)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
