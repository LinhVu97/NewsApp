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
    
    // Hàm này sẽ được gọi trước khi cell được tái sử dụng, ta có thể reset lại dữ liệu của các cell trước khi được tái sử dụng.
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCell.image = nil
        descriptionCell.text = nil
        titleCell.text = nil
    }
    
    func setupCell(_ title: String, _ description: String, _ image: String) {
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
