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
        
        self.navigationItem.hidesBackButton = true
        
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain , target: self, action: #selector(NotificationVC.back(sender:)))
        
        self.navigationItem.leftBarButtonItem = newBackButton

        let url =  URL(string: "http://clubhybridmodules.prisms.in/notifications/200/492")
        let request = URLRequest(url: url!)
        
        notificationWebview.load(request)
    }
    
    @objc func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
