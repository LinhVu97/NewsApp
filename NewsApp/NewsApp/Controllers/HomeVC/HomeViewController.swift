//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        APIManager.shared.getData(query: "business") { result in
            print(result)
        }
    }

    // Setup view
    private func setupView() {
        view.backgroundColor = .red
    }
}
