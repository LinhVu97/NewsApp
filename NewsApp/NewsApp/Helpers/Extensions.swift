//
//  Extensions.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import Foundation
import UIKit

extension UIViewController {
    // MARK: - Setup Navigation Bar
    func setupNavigationBar() {
        let image = UIImageView(image: UIImage(named: "abc-news-logo"))
        image.frame = CGRect(x: 0, y: 0, width: 100, height: 60)
        image.contentMode = .scaleAspectFit
        navigationItem.titleView = image
        navigationController?.navigationBar.barTintColor = .white
        
        // Hide line bottom navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - Setup Table View
    func setupTableView(_ tableView: UITableView) {
        let nib = UINib(nibName: CustomTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        // Remove line table when cell nil
        tableView.tableFooterView = UIView()
        
        tableView.estimatedRowHeight = 80 // Height cell default
        tableView.rowHeight = UITableView.automaticDimension // Auto height cell
    }
    
    // MARK: - Setup Indicator
    func setupIndicator(_ indicator: UIActivityIndicatorView) {
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
    }
    
    // MARK: - Add ViewController is chil
    func setupTabLayout(_ businessVC: UIViewController,
                        _ techVC: UIViewController,
                        _ sportVC: UIViewController,
                        _ businessView: UIView,
                        _ techView: UIView,
                        _ sportView: UIView) {
        // Add the view controller as a child
        addChild(businessVC)
        addChild(techVC)
        addChild(sportVC)

        // Notify the child that it was moved to a parent
        businessVC.didMove(toParent: businessVC)
        techVC.didMove(toParent: techVC)
        sportVC.didMove(toParent: sportVC)

        // Move the child view controller's view to the parent's view
        businessView.addSubview(businessVC.view)
        techView.addSubview(techVC.view)
        sportView.addSubview(sportVC.view)
    }
    
    // MARK: - Alert
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localized.OK, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
