//
//  EmptyViewController.swift
//  NewsApp
//
//  Created by Vũ Linh on 13/07/2021.
//

import UIKit

class EmptyViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = Localized.noData
        textLabel.text = Localized.showData
    }
}
