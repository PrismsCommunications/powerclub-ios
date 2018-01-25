//
//  ViewController.swift
//  Power Club
//
//  Created by Prisms Communications on 11-04-2015.
//  Copyright © 2018 Prisms Communications. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtOtp: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    
    struct JsongetOTP {
        let sid : String
        let fun_name: String
        let userId: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func GenerateOTP(_ sender: Any)
    {
        guard let url = URL(string: "http://topschool.prisms.in/rest/index.php/user_list.json") else { return }
        
        let jsonData = ["sid":"492",
                        "fun_name":"loginUserByOTPFromApple",
                        "mobile_no":"8888876264",
                        "school":"testClub"]
        //{"sid":"492","fun_name":"loginUserByOTPFromApple","mobile_no":"8888876264","school":"testClub"}
        
        
        if !jsonData.isEmpty {
                var request = URLRequest(url: url)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "POST"
            
                do
                {
                    let jsonBody = try JSONSerialization.data(withJSONObject: jsonData, options: [])
                    request.httpBody = jsonBody
                }catch{}
            
                
                let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response , err ) in
                    
                    guard let data =  data else { return }
                    
                    do
                    {
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        print(json)
                    }
                    catch let jsonErr_ {
                        
                    }
                })
                task.resume()
            }
    }
    
    @IBAction func login(_ sender: Any) {
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

