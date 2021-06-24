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
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Home Controller
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        // Search Controller
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        // Setting Controller
        let settingVC = SearchViewController()
        settingVC.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "gearshape"), tag: 2)
        
        let tabbar = UITabBarController()
        tabbar.viewControllers = [homeVC, searchVC, settingVC]
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()

        CoreData.shared.saveContext()
    }
}
