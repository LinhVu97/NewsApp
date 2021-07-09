//
//  ExtensionsImageView.swift
//  NewsApp
//
//  Created by Vũ Linh on 07/07/2021.
//

import Foundation
import UIKit

// MARK: - Extension UIImageView
extension UIImageView {
    func loadImage(url: URL, fail: ((Error) -> Void)?) {
        let tasks = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else {
                return
            }
            
            do {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            } catch {
                fail?(error)
            }
        }
        tasks.resume()
    }
}
