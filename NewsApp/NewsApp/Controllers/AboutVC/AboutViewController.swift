//
//  AboutViewController.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var descriptionAbout: UILabel!
    @IBOutlet weak var titleAbout: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionAbout.text = Localized.descriptionAbout
        titleAbout.text = Localized.about
    }
}
