//
//  TabbarViewController.swift
//  NewsApp
//
//  Created by Vũ Linh on 25/06/2021.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create instance of view controllers
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let settingVC = SettingViewController()
        
        // Set title
        homeVC.title = "Home"
        searchVC.title = "Search"
        settingVC.title = "Setting"
        
        // Set item tab bar
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        settingVC.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "gearshape"), tag: 2)
        
        // assign view controllers to tab bar
        self.setViewControllers([homeVC, searchVC, settingVC], animated: true)
    }

}
