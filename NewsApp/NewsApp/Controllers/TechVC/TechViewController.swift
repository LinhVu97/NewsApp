//
//  TechViewController.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import UIKit

class TechViewController: UIViewController {
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var techNews = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        getData()
    }
    
    // Get Data
    private func getData() {
        setupIndicator(indicator)
        APIService<Posts>.init(request: APIRequest(query: Categories.tech.rawValue, method: .GET)).callAPI { [weak self] result in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self?.techNews = posts.posts
                    self?.tableView.reloadData()
                    self?.indicator.stopAnimating()
                    self?.view.isUserInteractionEnabled = true
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    self?.alert(title: Localized.error, message: Localized.cannotLoadData)
                }
                print(err)
            }
        }
    }
}

extension TechViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return techNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let techNews = techNews[indexPath.row]
        
        // Connect to Custom Table View Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                       for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.model(techNews.title,
                   techNews.text ?? "No Description",
                   techNews.thread.mainImage ?? Query.urlNoImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let techNews = techNews[indexPath.row]
        let vc = DetailNewsViewController()
        vc.model = techNews // Pass Data to DetailNews
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
