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
        refreshData()
    }
    
    // Get Data
    private func getData() {
        setupIndicator(indicator)
        APIService<Posts>.init(request: APIRequest(query: Categories.tech.rawValue,
                                                   method: .GET)).callAPI { [weak self] result in
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
                    self?.indicator.stopAnimating()
                    self?.indicator.isHidden = true
                }
                print(err)
            }
        }
    }
    
    // MARK: - Refresh Table View
    private func refreshData() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(actionRefresh), for: .valueChanged)
    }
    
    @objc func actionRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableView.refreshControl?.endRefreshing()
            self.getData()
        }
    }
}

extension TechViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if techNews.count == 0 {
            let vc = EmptyViewController()
            tableView.addSub(tableView, vc)
        } else {
            tableView.restore()
        }
        return techNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let techNews = techNews[indexPath.row]
        
        // Connect to Custom Table View Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                       for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(techNews.title,
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
