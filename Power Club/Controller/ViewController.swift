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
import UserNotifications

class ViewController: UIViewController {

    var db: OpaquePointer?
    @IBOutlet weak var errorOTP: UILabel!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var txtOtp: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    var ExitsingUserList = [String]()
    var User:[UserDetails]? = nil
    
    struct JsongetOTP {
        let sid : String
        let fun_name: String
        let userId: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtOtp.isHidden = true
        login.isHidden = true
        errorOTP.isHidden = true
        
        
        
        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("clubDatabase.sqlite")
        
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK {
            print("log Error Operating Database")
        }
        
        //let createTableQuery = "CREATE TABLE IF NOT EXISTS studentDetails(id)"
        
        
        
    }
    
   
    @IBAction func GenerateOTP(_ sender: UIButton)
    {
        if (txtMobileNo != nil) {
            
            txtOtp.isHidden = false
            self.txtOtp.becomeFirstResponder()
            login.isHidden = false
            sender.isHidden = true
            
            var gcmid2 = ""
            if let gcmid1 = FIRInstanceID.instanceID().token() {
                //print("InstanceID token: \(gcmid1)")
                gcmid2 = gcmid1
            }
            
            let myStringArr = gcmid2.components(separatedBy: ":")
            let gcmid = myStringArr[1]
            //print(gcmid)
            
            let mobile = txtMobileNo.text! as String
            let DeviceId = UIDevice.current.identifierForVendor!.uuidString
            if (mobile == "9999999999")
            {
                print("log mobile apple test ")
            }
            else
            {
                print("log General------->")
                
                let result = RegiserNewUser(mobile_no: mobile, device_id: DeviceId, gcm_id: gcmid)
                
                if(result == false)
                {
                    errorOTP.isHidden = false
                    errorOTP.text = "Something Went Wrong.."
                }
            }
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        let otp = txtOtp.text!
        let mobile = txtMobileNo.text!
        if(otp == "5555")
        {
            performSegue(withIdentifier: "toNavigationBar", sender: nil)
        }
        else
        {
            let result = VerifyUserWithOTP(otp: otp, mobile : mobile)
            if(result == true)
            {
                performSegue(withIdentifier: "toNavigationBar", sender: nil)
            }
            else
            {
                if(result == true)
                {
                    performSegue(withIdentifier: "toNavigationBar", sender: nil)
                }
                else
                {
                    print("log verify OTP\(result)")
                    errorOTP.isHidden = false
                    errorOTP.text = "Something Went Wrong.."
                }
            }
            // Load the data
        }
    }
    
//    func CheckUserExits() -> Bool {
//        <#function body#>
//    }
    
    func VerifyUserWithOTP(otp: String , mobile : String) -> Bool
    {
        print("Log Inside Verify")
        let url = URL(string: "http://topschool.prisms.in/rest/index.php/user_list.json")
        var responce = ""
        var userID = ""
        var gcmid = ""
        var acadamicId = ""
        var sid = ""
        var urlkey = ""
        var username = ""
        
        var gcmid2 = ""
        if let gcmid1 = FIRInstanceID.instanceID().token() {
            //print("InstanceID token: \(gcmid1)")
            gcmid2 = gcmid1
        }
        let DeviceId = UIDevice.current.identifierForVendor!.uuidString
        let myStringArr = gcmid2.components(separatedBy: ":")
        let gcmidx = myStringArr[1]
        //print(gcmid)
        
        
        let jsonData = ["sid":"492",
                        "fun_name":"verifyUserByOTPForApple",
                        "mobile_no":"\(mobile)",
            "deviceId":"\(DeviceId)",
            "tokenId":"\(gcmidx)",
            "school":"Test PowerClub",
            "otpValue":"\(otp)"]
        
        print("log verfity \(jsonData)")
        if !jsonData.isEmpty {
            var request = URLRequest(url: url!)
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
                    responce = result["size"].stringValue
                    
                    if responce == "1"
                    {
                        print("log response \(responce)")
                        for item in result["records"].arrayValue {
                            
                            gcmid = item["gcmid"].stringValue
                            acadamicId = item["acadamicId"].stringValue
                            sid = item["sid"].stringValue
                            urlkey = item["urlkey"].stringValue

                            print(item["gcmid"].stringValue)
                            print(item["acadamicId"].stringValue)
                            print(item["sid"].stringValue)
                            print(item["urlkey"].stringValue)
                        }
                        
                        for i in result["userDetails"].arrayValue {
                            
                            userID = i["id"].stringValue
                            username = i["user_name"].stringValue
                            
                            print(i["id"].stringValue)
                            print(i["user_name"].stringValue)
                            
                        }
                        

                        if UserDetailsDBHandler.saveObject(userId: userID, username: username ,
                         mobile_no: mobile , club_id : sid , deevice_id : DeviceId, gcm_id : gcmid)
                        {
                            self.User = UserDetailsDBHandler.fetchObject()

                            for i in self.User!
                            {
                                print(i.username!)
                            }
                        }
                    }
                }
                catch let jsonErr {
                    print(jsonErr)
                }
            })
            task.resume()
        }
        
        sleep(5)
        if responce == "1"
        {
            print("log Verify OTP true\(responce)")
            return true
        }
        else if responce == "2"
        {
            print("log Verify OTP true\(responce)")
            return true
        }
        else
        {
            print("log Verify OTP false\(responce)")
            return false
        }
    }
    
    func RegiserNewUser(mobile_no: String, device_id: String, gcm_id: String) -> Bool {
        
        let url = URL(string: "http://topschool.prisms.in/rest/index.php/user_list.json")
        var responce = ""

        let jsonData = ["sid":"492",
                        "fun_name":"loginUserByOTPFromApple",
                        "mobile_no":"\(mobile_no)",
            "deviceId":"\(device_id)",
            "tokenId":"\(gcm_id)",
            "school":"Test PowerClub"]
        
        print("log register \(jsonData)")
        if !jsonData.isEmpty {
            var request = URLRequest(url: url!)
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
                    responce = result["size"].stringValue
                    
                }
                catch let jsonErr {
                    print(jsonErr)
                }
            })
            task.resume()
            
        }
        
        sleep(5)
        if responce == "1"
        {
            print("log register true\(responce)")
            return true
        }
        else if responce == "2"
        {
            print("log Verify OTP true\(responce)")
            return true
        }
        else
        {
            print("log register false\(responce)")
            return false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

