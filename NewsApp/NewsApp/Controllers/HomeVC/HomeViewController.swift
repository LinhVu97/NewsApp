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
    
    // Create Horizontal Bar
    lazy var horizontalBar: UIView = {
        let horizontalBar = UIView()
        horizontalBar.backgroundColor = UIColor(white: 0.9, alpha: 1)
        horizontalBar.backgroundColor = .systemBlue

        // Frame
        horizontalBar.frame = CGRect(x: 7, y: 160, width: 105, height: 3)
        return horizontalBar
    }()
    
    let businessVC = BusinessViewController()
    let techVC = TechViewController()
    let sportVC = SportViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(horizontalBar)
        
        setupNavigationBar()
        setupViewScrollView()
        buttonLocalizable()
        businessButton.isUserInteractionEnabled = false
    }

    // MARK: - Setup
    // Setup Button
    private func buttonLocalizable() {
        businessButton.setTitle(Localized.business, for: .normal)
        techButton.setTitle(Localized.tech, for: .normal)
        sportButton.setTitle(Localized.sports, for: .normal)
    }
    
    // Setup Scroll View
    private func setupViewScrollView() {
        let number: CGFloat = 3
        scrollView.contentSize = CGSize(width: view.frame.width * number, height: view.frame.height)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        setupTabLayout(businessVC, techVC, sportVC, businessView, techView, sportView)
    }
    
    // Animate Horizontal Bar
    private func animate(x: CGFloat) {
        UIView.animate(withDuration: 0.2, delay: 0.1, options: [], animations: {
            self.horizontalBar.frame = CGRect(x: x, y: 160, width: 105, height: 3)
        }, completion: nil)
    }
    
    // MARK: - Button
    @IBAction func buisiness(_ sender: UIButton) {
        animate(x: 7)
        // Move content
        scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
        isUserInteractionEnabled(b1: businessButton, b2: techButton, b3: sportButton)
    }

    @IBAction func tech(_ sender: UIButton) {
        animate(x: 135)
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width, y: scrollView.contentOffset.y), animated: true)
        isUserInteractionEnabled(b1: techButton, b2: businessButton, b3: sportButton)
    }

    @IBAction func sport(_ sender: UIButton) {
        animate(x: 265)
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width * 2, y: scrollView.contentOffset.y),
                                    animated: true)
        isUserInteractionEnabled(b1: sportButton, b2: businessButton, b3: techButton)
    }
    
    // User Interaction Enable
    private func isUserInteractionEnabled(b1: UIButton, b2: UIButton, b3: UIButton) {
        b1.isUserInteractionEnabled = false
        if b1.isUserInteractionEnabled == false {
            b2.isUserInteractionEnabled = true
            b3.isUserInteractionEnabled = true
        }
    }
}

extension HomeViewController: UIScrollViewDelegate {
    // Animate Horizontal when Scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            animate(x: 7)
        } else if scrollView.contentOffset.x == scrollView.frame.width {
            animate(x: 135)
        } else if scrollView.contentOffset.x == scrollView.frame.width * 2 {
            animate(x: 265)
        }
    }
}
