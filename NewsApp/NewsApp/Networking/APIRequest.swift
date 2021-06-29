//
//  APIRequest.swift
//  NewsApp
//
//  Created by Vũ Linh on 28/06/2021.
//

import Foundation

enum APIMethod: String {
    case GET
    case POST
    case DELETE
    case PUT
}

struct APIRequest {
    var query: String
    var method: APIMethod
    var url: String {
        return APIKey.baseURL + query
    }
    
    // URL Request
    func urlRequest() -> URLRequest {
        var urlRequest = URLRequest(url: (URL(string: url) ?? URL(string: "")!))// Unwrap URL Request
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
    
    func printInfomationRequest() {
        print("Request url : \(url)")
        print("Request method : \(method)")
    }
}
