//
//  HistoryViewController.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var historyNews = [News]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        // Navigation Right Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(removeNews))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    // Fetch Data
    private func fetchData() {
        NewsCore.all(predicate: nil) { [weak self] news in
            if let news = news as? [NewsCore] {
                _ = news.map { new in
                    self?.historyNews.append(News(thread: NewsDetail(mainImage: new.image),
                                                 author: new.author,
                                                 text: new.text,
                                                 url: new.url ?? "",
                                                 title: new.title ?? "",
                                                 published: new.published))
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }
        } fail: { err in
            print("Fetch fail: \(err)")
        }
    }

    // Remove News
    @objc private func removeNews() {
        
    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let historyNews = historyNews[indexPath.row]
        
        // Connect to Custom Table View Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                       for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(historyNews.title,
                   historyNews.text ?? "",
                   historyNews.thread.mainImage ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let historyNews = historyNews[indexPath.row]
        let vc = DetailNewsViewController()
        vc.model = historyNews // Pass data to DetailNews
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
