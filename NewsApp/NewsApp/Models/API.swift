//
//  API.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    // Get data from API
    func getData(query: String, completion: @escaping (Result<[News], Error>) -> Void) {
        guard let url = URL(string: "http://webhose.io/filterWebContent?token=7130dd35-bb7b-4fa5-8736-082fbc7a9900&q=site_type:news%20country:US%20site_category:\(query)")
        else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                
                return
            }
            
            do {
                let posts = try JSONDecoder().decode(Posts.self, from: data)
                let news = posts.posts
                completion(.success(news))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
