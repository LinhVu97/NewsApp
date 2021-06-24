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

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setup()
        return true
    }
    
    private func setup() {
        // Window full screen
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Home Controller
        let homeVC = HomeViewController()
        self.window?.rootViewController = homeVC
        self.window?.makeKeyAndVisible()
        
        // Test
        CoreData.coreData.saveContext()
    }
}
