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
    @IBOutlet weak private var containerView: UIView!
    
    var searchNews = [News]()
    var textString = [String]()
    
    let emptyView = EmptyViewController()
    let tableSearchView = TableSearchViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        searchBar.delegate = self
        searchBar.placeholder = "Search News ..."
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    private func setupTable() {
        setupTableView(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Dismiss Keybroad
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchNews.count == 0 {
            let vc = EmptyViewController()
            tableView.addSub(tableView, vc)
        } else {
            tableView.restore()
        }
        return searchNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchNews = searchNews[indexPath.row]
        
        // Connect to Custom Table View Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                       for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(searchNews.title,
                       searchNews.text ?? "",
                       searchNews.thread.mainImage ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let searchNews = searchNews[indexPath.row]
        let vc = DetailNewsViewController()
        vc.model = searchNews // Pass data to DetailNews
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Search with search text
        if !searchText.isEmpty {
            search(searchText: searchText)
            addSubSearchView(vc: tableSearchView)
        }
        else {
            addSubSearchView(vc: emptyView)
        }
        searchNews.removeAll()
        tableView.reloadData()
    }
    
    // Sub search view
    private func addSubSearchView(vc: UIViewController) {
        addChild(vc)
        containerView.addSubview(vc.view)
        didMove(toParent: vc)
    }
    
    // Search
    private func search(searchText: String) {
        NewsCore.all(predicate: nil) { [weak self] news in
            DispatchQueue.main.async { [self] in
                if let news = news as? [NewsCore] {
                    _ = news.map { new in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        if new.title?.lowercased().contains(searchText.lowercased()) ?? false {
                                self?.searchNews.append(News(thread: NewsDetail(mainImage: new.image),
                                                             author: new.author,
                                                             text: new.text,
                                                             url: new.url ?? "",
                                                             title: new.title ?? "",
                                                             published: new.published))
                                self?.textString.append(searchText)
                                self?.textString = self?.textString.uniqued() ?? []
                            }
                        }
                    }
                    self?.tableSearchView.text = self?.textString ?? []
                    self?.tableSearchView.tableView.reloadData()
                    self?.tableView.reloadData()
                }
            }
        } fail: { err in
            print("Fetch fail: \(err)")
        }
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
