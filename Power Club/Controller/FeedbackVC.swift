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
    
    @IBAction func backButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url =  URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSc4WYUzqAN260a-PauG6WQfhFSJ8wG62o4Ki2Iwb9OOaDbbFQ/viewform?entry.325730274=test&entry.821088630=9930055390")
        let request = URLRequest(url: url!)
        
        FeedbackWebView.load(request)
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
