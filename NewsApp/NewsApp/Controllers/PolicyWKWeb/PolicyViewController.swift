//
//  PolicyViewController.swift
//  NewsApp
//
//  Created by Vũ Linh on 30/06/2021.
//

import UIKit
import WebKit

class PolicyViewController: UIViewController {
    @IBOutlet weak private var webView: WKWebView!
    @IBOutlet weak private var spinner: UIActivityIndicatorView!
    @IBOutlet weak private var backButton: UIBarButtonItem!
    @IBOutlet weak private var fowardButton: UIBarButtonItem!
    @IBOutlet weak private var reloadButton: UIBarButtonItem!
    
    let urlPolicy = "https://www.abc.net.au/news/politics/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    // Setup Webview
    private func setupWebView() {
        guard let url = URL(string: urlPolicy) else {
            return
        }

        webView.load(URLRequest(url: url))
        webView.addSubview(spinner)
        
        webView.navigationDelegate = self
        spinner.hidesWhenStopped = true
    }
     
    // MARK: - Button
    @IBAction func backButton(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    @IBAction func fowardButton(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func reloadButton(_ sender: Any) {
        webView.reload()
    }
}

extension PolicyViewController: WKNavigationDelegate, WKUIDelegate {
    // Called when webview begins receive web contents
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        spinner.startAnimating()
    }
    
    // Called when did finish
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
    
    // Error when load
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        spinner.stopAnimating()
    }
}
