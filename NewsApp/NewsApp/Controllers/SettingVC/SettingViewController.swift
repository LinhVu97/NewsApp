//
//  SettingViewController.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak private var tableView: UITableView!
    
    private var items = [Localized.history, Localized.changeLanguage, Localized.policy, Localized.about]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableViewSetting()
    }

    // MARK: - Setup Table View
    private func setupTableViewSetting() {
        tableView.tableFooterView = UIView() // Remove line table when cell nil
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Select cell
        switch indexPath.row {
        case 0:
            changeViewController(vc: HistoryViewController(), title: Localized.history)
        case 1:
            changeViewController(vc: ChangeLanguageViewController(), title: Localized.changeLanguage)
        case 2:
            let vc = WKWebViewController()
            vc.urlString = Query.urlPolicy
            changeViewController(vc: vc, title: Localized.policy)
        case 3:
            changeViewController(vc: AboutViewController(), title: Localized.about)
        default:
            break
        }
    }
    
    private func changeViewController(vc: UIViewController, title: String) {
        let vc = vc
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }
}
