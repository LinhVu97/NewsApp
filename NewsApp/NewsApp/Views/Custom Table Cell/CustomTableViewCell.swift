//
//  CustomTableViewCell.swift
//  NewsApp
//
//  Created by Vũ Linh on 29/06/2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    
    @IBOutlet weak private var imageCell: UIImageView!
    @IBOutlet weak private var descriptionCell: UILabel!
    @IBOutlet weak private var titleCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func model(_ title: String, _ description: String, _ image: String) {
        titleCell.text = title
        descriptionCell.text = description

        // Image View
        guard let url = URL(string: image) else {
            return
        }
        
        imageCell.loadImage(url: url) { err in
            fatalError(err.localizedDescription)
        }
    }
}
