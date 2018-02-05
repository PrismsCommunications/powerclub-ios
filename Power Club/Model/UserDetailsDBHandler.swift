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
        , mobile_no: String , club_id : String , deevice_id : String , gcm_id : String) -> Bool{
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "UserDetails", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(userId, forKey: "userId")
        manageObject.setValue(username, forKey: "username")
        manageObject.setValue(mobile_no, forKey: "mobile_no")
        manageObject.setValue(club_id, forKey: "club_id")
        manageObject.setValue(deevice_id, forKey: "deevice_id")
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
    
    class func searchdata(username: String) -> [UserDetails]? {
        let context = getContext()
        let fetchRQ : NSFetchRequest<UserDetails> = UserDetails.fetchRequest()
        var User:[UserDetails]? = nil
        
        let predicate = NSPredicate(format: "username contains[c] %@", username)
        fetchRQ.predicate = predicate
        
        do{
            User = try context.fetch(fetchRQ)
            return User
        }catch{
            return User
        }
    }
    
}
