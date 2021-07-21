//
//  DetailNewsViewController.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import UIKit
import CoreData

class DetailNewsViewController: UIViewController {
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleView: UILabel!
    @IBOutlet weak private var author: UILabel!
    @IBOutlet weak private var published: UILabel!
    @IBOutlet weak private var text: UILabel!
    @IBOutlet weak private var linkFull: UILabel!
    
    var model: News?
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tapgesture()
        detailNews()
        context = AppDelegate.manageObjectContext
        
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
        // Add history
        alert.addAction(UIAlertAction(title: Localized.OK, style: .default, handler: { _ in
            self.addNews()
            self.alert(title: Localized.success, message: Localized.success)
        }))
        alert.addAction(UIAlertAction(title: Localized.cancel, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func addNews() {
        guard let model = self.model else {
            return
        }
        
        let news = NewsCore(context: context)
        news.image = model.thread.mainImage
        news.title = model.title
        news.text = model.text
        news.author = model.author
        news.published = model.published
        news.url = model.url
        news.save {
            self.alert(title: Localized.success, message: Localized.success)
        } fail: { _ in
            self.alert(title: Localized.error, message: Localized.cannotLoadData)
        }
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
        imageView.loadImage(url: url) { [weak self] _ in
            self?.alert(title: Localized.error, message: Localized.cannotLoadData)
        }
        
        // Date Formatter
        let date = Date()
        published.text = date.toString()
    }
}
