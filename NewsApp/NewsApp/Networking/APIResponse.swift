//
//  APIResponse.swift
//  NewsApp
//
//  Created by Vũ Linh on 28/06/2021.
//

import Foundation
import UIKit

struct APIService <T: Codable> {
    var request: APIRequest?
    
    func callAPI(completion: @escaping (Result<T, APIError>) -> Void) {
        request?.printInfomationRequest()

        // Đảm bảo rằng có URL gọi từ URLRequest
        guard let url = request?.urlRequest() else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Check respone within (200 ... 299)
            guard let res = response as? HTTPURLResponse, (200...299).contains(res.statusCode) else {
                completion(.failure(.responseFailed(APIErrorKey.responseFail)))
                return
            }

            guard error == nil else {
                completion(.failure(.requestFailed(APIErrorKey.requestFail)))
                return
            }

            guard let data = data else {
                completion(.failure(.noDataAvailable(APIErrorKey.noData)))
                return
            }

            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            } catch {
                completion(.failure(.cannotProcessData(APIErrorKey.cannotProcessData)))
            }
        }

        task.resume()
    }
}
