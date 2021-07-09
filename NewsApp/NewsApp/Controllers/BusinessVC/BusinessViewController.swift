//
//  BusinessViewController.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import UIKit

class BusinessViewController: UIViewController {
    @IBOutlet weak private var tableView: UITableView! 
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var businessNews = [News]()
    
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
        APIService<Posts>.init(request: APIRequest(query: Query.business, method: .GET)).callAPI { [weak self] result in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self?.businessNews = posts.posts
                    self?.tableView.reloadData()
                    self?.indicator.stopAnimating()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    self?.alertError()
                }
                print(err)
            }
        }
    }
}

extension BusinessViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let businessNews = businessNews[indexPath.row]
        
        // Connect to Custom Table View Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                       for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.model(businessNews.title,
                   businessNews.text ?? "No Description",
                   businessNews.thread.mainImage ?? Query.urlNoImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = DetailNewsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
