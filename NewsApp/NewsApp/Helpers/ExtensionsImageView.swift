//
//  ExtensionsImageView.swift
//  NewsApp
//
//  Created by Vũ Linh on 07/07/2021.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

// MARK: - Extension UIImageView
extension UIImageView {
    func loadImage(url: URL, fail: ((Error) -> Void)?) {
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        let tasks = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else {
                return
            }

            do {
                DispatchQueue.main.async {
                    guard let imageToCache = UIImage(data: data) else {
                        return
                    }
                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                    self?.image = imageToCache
                }
            } catch {
                fail?(error)
            }
        }
        tasks.resume()
    }
}
