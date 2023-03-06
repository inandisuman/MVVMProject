//
//  PersistentStoreManager.swift
//  MVVMProject
//
//  Created by Suman Nandi on 05/03/23.
//

import Foundation
import CoreData

// MARK: - Core Data stack

class PersistentStoreManager {
    
    static let shared = PersistentStoreManager()
    
    private init() {}
    
    var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "MVVMProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data : CREATE
    func createData(for data: LoginUser) -> Bool {
        // Create a context from this container
        let managedContext = persistentContainer.viewContext
        // Create an entity
        let entity = NSEntityDescription.entity(forEntityName: "LoginUser", in: managedContext)
        guard let entity = entity  else {
            debugPrint("Could not save")
            return false
        }
        let loginUser = NSManagedObject(entity: entity, insertInto: managedContext)
        // Set managed object value for each key
        loginUser.setValue(data.username, forKey: "username")
        loginUser.setValue(data.password, forKey: "password")
        loginUser.setValue(data.country, forKey: "country")
        
        // Save context
        do {
            try managedContext.save()
        } catch let error as NSError {
            debugPrint("Could not save : \(error.userInfo)")
            return false
        }
        return true
    }
    
    // MARK: - Core Data : READ
    func readData() -> LoginUser? {
        // Create a context from this container
        let managedContext = persistentContainer.viewContext
        // Prepare the NSFetchRequest for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginUser")
        // Retrieve data from context
        do {
            let result = try managedContext.fetch(fetchRequest).first as! LoginUser
            return result
        } catch let error as NSError {
            debugPrint("Could not retrieve : \(error.userInfo)")
        }
        return nil
    }
    
    // MARK: - Core Data : SAVE
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
