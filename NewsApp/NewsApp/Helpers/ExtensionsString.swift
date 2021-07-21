//
//  ExtensionsString.swift
//  NewsApp
//
//  Created by Vũ Linh on 05/07/2021.
//

import Foundation
import UIKit

let languageKey = "app_lang"

extension String {
    var localized: String {
        let lang = UserDefaults.standard.string(forKey: languageKey) // Get value as String
        let path = Bundle.main.path(forResource: lang ?? "en", ofType: "lproj")
        let bundle = Bundle(path: path ?? "")
        return NSLocalizedString(self, tableName: nil, bundle: bundle ?? Bundle(), value: "", comment: "")
    }
}
