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

        // Delay Thread
        Thread.sleep(forTimeInterval: 0.5)

        setup()
        return true
    }
}
