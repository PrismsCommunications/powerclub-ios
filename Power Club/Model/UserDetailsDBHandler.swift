//
//  UserDetailsDBHandler.swift
//  Power Club
//
//  Created by Prisms Communications on 11-04-2015.
//  Copyright © 2018 Prisms Communications. All rights reserved.
//

import UIKit
import CoreData

class UserDetailsDBHandler: NSObject {

    
    private class func getContext()  -> NSManagedObjectContext{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveObject(userId: String, username: String
        , mobile_no: String , club_id : String , device_id : String , gcm_id : String) -> Bool{
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "UserDetails", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(userId, forKey: "userId")
        manageObject.setValue(username, forKey: "username")
        manageObject.setValue(mobile_no, forKey: "mobile_no")
        manageObject.setValue(club_id, forKey: "club_id")
        manageObject.setValue(device_id, forKey: "device_id")
        manageObject.setValue(gcm_id, forKey: "gcm_id")
        
        do{
            try context.save()
            return true
        }catch
        {
            return false
        }
    }
    
    class func fetchObject() -> [UserDetails]?
    {
        let context = getContext()
        var User:[UserDetails]? = nil
        do{
            User = try context.fetch(UserDetails.fetchRequest())
            return User
        }catch{
            return User
        }
    }
    
    class func searchdata(mobile_no: String) -> [UserDetails]? {
        let context = getContext()
        let fetchRQ : NSFetchRequest<UserDetails> = UserDetails.fetchRequest()
        var User:[UserDetails]? = nil
        
        let predicate = NSPredicate(format: "mobile_no contains[c] %@", mobile_no)
        fetchRQ.predicate = predicate
        
        do{
            User = try context.fetch(fetchRQ)
            return User
        }catch{
            return User
        }
    }
    
}
