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
import SwiftyJSON

class ViewController: UIViewController {

    var db: OpaquePointer?
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var txtOtp: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var ErrorMsg: UILabel!
    
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
        startProg()
        var name = ""
        let mobile_ = txtMobileNo.text!
        let DeviceId = UIDevice.current.identifierForVendor!.uuidString
        
        print(DeviceId)
    
        guard let url = URL(string: "http://topschool.prisms.in/rest/index.php/user_list.json") else { return }
        
        let jsonData = ["sid":"492",
                        "fun_name":"loginUserByOTPFromApple",
                        "mobile_no":mobile_,
                        "school":"testClub",
                        "device_id":DeviceId]
        
        print(jsonData)
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
       
         sleep(4)
         stopProg()
        if(name == "1")
        {
            ValidateOTP()
        }
        else
        {
            print("Pleasee check somethin is wrong....")
        }
    }
    @IBAction func LoginDemo(_ sender: Any) {
    }
    
    func ValidateOTP()
    {
        //print("ok call")
        //1. Create the alert controller.
        let alert = UIAlertController(title: "OTP Verification", message: "Please Enter Given OTP", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
            let res : Bool = self.OTPverifyFromServer()
            if(res != true)
            {
                print("Please try Again...!")
                self.ErrorMsg.isHidden = false
            }
            else
            {
                print("Welcome")
                self.ErrorMsg.isHidden = true
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Login", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Dashboard") as! DashBoardViewController
                
                self.present(nextViewController, animated:true, completion:nil)
                
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func OTPverifyFromServer() -> Bool
    {
        
        
        return true
    }
    
    func startProg()
    {
        //print("Start")
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()

    }
    
    func stopProg() {
        //print("Stop")
        activityIndicator.stopAnimating()
    }

}


