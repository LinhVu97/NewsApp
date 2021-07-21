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
        let homeNavi = UINavigationController(rootViewController: homeVC)
        
        let searchVC = SearchViewController()
        let searchNavi = UINavigationController(rootViewController: searchVC)
        
        let settingVC = SettingViewController()
        let settingNavi = UINavigationController(rootViewController: settingVC)
        
        // Set title
        homeVC.title = Localized.home
        searchVC.title = Localized.search
        settingVC.title = Localized.setting
        
        // Set item tab bar
        homeVC.tabBarItem = UITabBarItem(title: Localized.home, image: UIImage(systemName: "house"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: Localized.search, image: UIImage(systemName: "magnifyingglass"), tag: 1)
        settingVC.tabBarItem = UITabBarItem(title: Localized.setting, image: UIImage(systemName: "gearshape"), tag: 2)
        
        // assign view controllers to tab bar
        self.setViewControllers([homeNavi, searchNavi, settingNavi], animated: true)
    }

}
