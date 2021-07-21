//
//  ChangeLanguageViewController.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import UIKit

class ChangeLanguageViewController: UIViewController {
    @IBOutlet weak private var eng: UILabel!
    @IBOutlet weak private var fr: UILabel!
    @IBOutlet weak private var vi: UILabel!
    @IBOutlet weak private var buttonEng: UIButton!
    @IBOutlet weak private var buttonFr: UIButton!
    @IBOutlet weak private var buttonVi: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
    }
    
    private func setupLabel() {
        eng.text = Localized.eng
        fr.text = Localized.fr
        vi.text = Localized.vi
    }
    
    // MARK: - Button
    @IBAction func changeEng(_ sender: UIButton) {
        UserDefaults.standard.set("en", forKey: languageKey) // Save value as String
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func changeFr(_ sender: UIButton) {
        UserDefaults.standard.set("fr", forKey: languageKey) // Save value as String
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func changVI(_ sender: UIButton) {
        UserDefaults.standard.set("vi", forKey: languageKey) // Save value as String
        UserDefaults.standard.synchronize()
    }
}
