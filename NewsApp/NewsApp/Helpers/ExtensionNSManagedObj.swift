//
//  ExtensionNSManagedObj.swift
//  NewsApp
//
//  Created by Vũ Linh on 08/07/2021.
//

import CoreData
import UIKit

extension NSManagedObject {
    // Class can override
    class var context: NSManagedObjectContext! {
        return AppDelegate.manageObjectContext
    }
    
    class var request: NSFetchRequest<NSManagedObject> {
        return NSFetchRequest(entityName: String(describing: self))
    }
    
    // Save Object
    func save(success: (() -> Void)?, fail: ((Error) -> Void)?) {
        guard let context = self.managedObjectContext else {
            fail?(NSError(domain: "", code: 1, userInfo: nil))
            return
        }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = NSError(domain: "Data not change", code: 0, userInfo: nil)
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    // Fetch Object
    class func all(predicate: NSPredicate?, success: (([NSManagedObject]) -> Void)?, fail: ((Error) -> Void)?) {
        request.predicate = predicate // -> predicate filter FIFO
        do {
            let result = try context.fetch(request)
            success?(result)
        } catch {
            fail?(error)
        }
    }
}
