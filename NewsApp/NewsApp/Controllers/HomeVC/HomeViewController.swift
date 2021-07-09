//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak private var businessButton: UIButton!
    @IBOutlet weak private var techButton: UIButton!
    @IBOutlet weak private var sportButton: UIButton!
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var businessView: UIView!
    @IBOutlet weak private var techView: UIView!
    @IBOutlet weak private var sportView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    // Create Horizontal Bar
    lazy var horizontalBar: UIView = {
        let horizontalBar = UIView()
        horizontalBar.backgroundColor = UIColor(white: 0.9, alpha: 1)
        horizontalBar.backgroundColor = .systemBlue
        horizontalBar.translatesAutoresizingMaskIntoConstraints = false
        return horizontalBar
    }()
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    let businessVC = BusinessViewController()
    let techVC = TechViewController()
    let sportVC = SportViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(horizontalBar)
        
        setupNavigationBar()
        setupViewScrollView()
        setupHorizontalBar()
        buttonLocalizable()
    }

    // MARK: - Setup
    // Setup Button
    private func buttonLocalizable() {
        businessButton.setTitle(Localized.business, for: .normal)
        techButton.setTitle(Localized.tech, for: .normal)
        sportButton.setTitle(Localized.sports, for: .normal)
    }
    
    // Setup Horizontal Bar
    func setupHorizontalBar() {
        horizontalBarLeftAnchorConstraint = horizontalBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBar.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        horizontalBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        horizontalBar.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    // Setup Scroll View
    private func setupViewScrollView() {
        let number: CGFloat = 3
        scrollView.contentSize = CGSize(width: view.frame.width * number, height: view.frame.height)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        setupTabLayout(businessVC, techVC, sportVC, businessView, techView, sportView)
    }
    
    // MARK: - Button
    @IBAction func buisiness(_ sender: UIButton) {
        // Move content
        scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
    }

    @IBAction func tech(_ sender: UIButton) {
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width, y: scrollView.contentOffset.y), animated: true)
    }

    @IBAction func sport(_ sender: UIButton) {
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width * 2, y: scrollView.contentOffset.y),
                                    animated: true)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    // Animate Horizontal when Scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
        if scrollView.contentOffset.x >= scrollView.bounds.width / 3 {
            if scrollView.contentOffset.x == scrollView.bounds.width {
                scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width,
                                                    y: scrollView.contentOffset.y),
                                            animated: true)
            }
        } else {
            if scrollView.contentOffset.x == 0 {
                scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
                scrollView.endEditing(true)
            }
        }
    }
}
