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
    
    @IBAction func backButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let url =  URL(string: "http://clubhybridmodules.prisms.in/holidays/200/492")
        let request = URLRequest(url: url!)
        
        HolidaysWebview.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
