//
//  ViewController.swift
//  Power Club
//
//  Created by Prisms Communications on 11-04-2015.
//  Copyright © 2018 Prisms Communications. All rights reserved.
//

import UIKit
import SQLite3
import Firebase
import FirebaseInstanceID
import FirebaseCore
import FirebaseMessaging
import SwiftyJSON


class ViewController: UIViewController {

    var db: OpaquePointer?
    
    @IBOutlet weak var txtOtp: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    
    struct JsongetOTP {
        let sid : String
        let fun_name: String
        let userId: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("clubDatabase.sqlite")
        
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK {
            print("Error Operating Database")
        }
        
        //let createTableQuery = "CREATE TABLE IF NOT EXISTS studentDetails(id)"
        
        
        
    }
    
    @IBAction func GenerateOTP(_ sender: Any)
    {
        var gcmid2 = ""
        if let gcmid1 = FIRInstanceID.instanceID().token() {
            //print("InstanceID token: \(gcmid1)")
            gcmid2 = gcmid1
        }
        
        let myStringArr = gcmid2.components(separatedBy: ":")
        let gcmid = myStringArr[1]
        //print(gcmid)
        
        var name = ""
        let mobile = txtMobileNo.text!
        let DeviceId = UIDevice.current.identifierForVendor!.uuidString
        
        guard let url = URL(string: "http://topschool.prisms.in/rest/index.php/user_list.json") else { return }
        
        let jsonData = ["sid":"492",
                        "fun_name":"verifyUserByOTPForApple",
                        "mobile_no":"\(mobile)",
                        "device_id":"\(DeviceId)",
                        "gcm_id":"\(gcmid)",
                        "school":"testClub"]
        print(jsonData)
        //{"sid":"492","fun_name":"loginUserByOTPFromApple","mobile_no":"8888876264","school":"testClub"}

        if !jsonData.isEmpty {
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
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
                    let result = JSON(json)
                    name = result["size"].stringValue
                    
                    if name == "1"
                    {
                        print(name)
                    }
                }
                catch let jsonErr {
                    print(jsonErr)
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

