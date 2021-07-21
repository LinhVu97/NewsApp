//
//  CoreData.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import Foundation
import CoreData

class CoreData {
    static let shared = CoreData()
    
    // MARK: - Core Data stack
        /// Func connect to Core Data
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsApp") // Name CSDL
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
        /// Save objec when have change
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
