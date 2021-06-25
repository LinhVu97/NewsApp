//
//  ExtensionsString.swift
//  NewsApp
//
//  Created by Vũ Linh on 05/07/2021.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
