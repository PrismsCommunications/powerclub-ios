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
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
