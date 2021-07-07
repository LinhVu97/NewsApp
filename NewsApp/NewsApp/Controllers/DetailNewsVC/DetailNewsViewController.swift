//
//  DetailNewsViewController.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import UIKit

class DetailNewsViewController: UIViewController {
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleView: UILabel!
    @IBOutlet weak private var author: UILabel!
    @IBOutlet weak private var published: UILabel!
    @IBOutlet weak private var text: UILabel!
    @IBOutlet weak private var linkFull: UILabel!
    
    var model: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tapgesture()
        detailNews()
        
        // Navigation Right Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(moveToHistory))
    }
    
    // MARK: - Tapgesture
    private func tapgesture() {
        linkFull.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tapLink))
        tapgesture.numberOfTapsRequired = 1
        linkFull.addGestureRecognizer(tapgesture)
    }
    
    @objc private func tapLink() {
        let vc = WKWebViewController()
        vc.urlString = model?.url
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Move to History
    @objc private func moveToHistory() {
        let alert = UIAlertController(title: "",
                                      message: Localized.addToHistory,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localized.OK, style: .default, handler: { _ in
            self.saveData()
        }))
        alert.addAction(UIAlertAction(title: Localized.cancel, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func saveData() {
        
    }
    
    // MARK: - Detail News
    private func detailNews() {
        titleView.text = model?.title
        author.text = model?.author
        text.text = model?.text
        linkFull.text = model?.url
        
        // Image View
        guard let url = URL(string: model?.thread.mainImage ?? Query.urlNoImage) else {
            return
        }
        imageView.loadImage(url: url)
        
        // Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        guard let date = dateFormatter.date(from: model?.published ?? "") else {
            return
        }
        published.text = dateFormatter.string(from: date)
    }
}
