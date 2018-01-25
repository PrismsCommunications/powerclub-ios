//
//  RestApiManager.swift
//  Power Club
//
//  Created by Prisms Communications on 11-04-2015.
//  Copyright © 2018 Prisms Communications. All rights reserved.
//

import Foundation

typealias ServiceResponce = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    let baseURL = ""

    func getOTP(onCompletion: (JSON) -> Void)
    {
        
    }
    
    func makeHttpRequest(path: String, onCompletion: ServiceResponce)
    {
        let request =  NSMutableURLRequest(URL: NSURL(String: path))
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request,completionHandler)
    }

}
