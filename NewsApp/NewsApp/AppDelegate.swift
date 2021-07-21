//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    static var manageObjectContext: NSManagedObjectContext? // Work with database
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 0.5) // Delay Thread
        setupView()
        AppDelegate.manageObjectContext = CoreData.shared.persistentContainer.viewContext // return context of database
        return true
    }
    
    // Setup Window View
    private func setupView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabbarViewController()
        window?.makeKeyAndVisible()
    }
}
