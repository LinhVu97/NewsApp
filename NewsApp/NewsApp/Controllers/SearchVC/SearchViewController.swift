//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var tableView: UITableView!
    
    var searchNews = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // Dismiss Keybroad
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchNews = searchNews[indexPath.row]
        
        // Connect to Custom Table View Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                       for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.model(searchNews.title,
                   searchNews.text ?? "",
                   searchNews.thread.mainImage ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchNews.removeAll()
        if !searchText.isEmpty {
            NewsCore.all(predicate: nil) { [weak self] news in
                DispatchQueue.main.async {
                    if let news = news as? [NewsCore] {
                        _ = news.map { new in
                            if new.title?.lowercased().contains(searchText.lowercased()) ?? false {
                                self?.searchNews.append(News(thread: NewsDetail(mainImage: new.image),
                                                             author: new.author,
                                                             text: new.text,
                                                             url: new.url ?? "",
                                                             title: new.title ?? "",
                                                             published: new.published))
                            }
                        }
                        self?.tableView.reloadData()
                    }
                }
            } fail: { err in
                print("Fetch fail: \(err)")
            }
        }
    }
}
