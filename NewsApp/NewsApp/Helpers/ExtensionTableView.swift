//
//  EmptyBackgroundView.swift
//  NewsApp
//
//  Created by Vũ Linh on 10/07/2021.
//

import UIKit

extension UITableView {
    func addSub(_ tableView: UITableView,_ vc: UIViewController) {
        tableView.addSubview(vc.view)
        tableView.backgroundView = vc.view
        tableView.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
