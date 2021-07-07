//
//  HistoryViewController.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation Right Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(removeNews))
    }

    @objc private func removeNews() {
        
    }
}
