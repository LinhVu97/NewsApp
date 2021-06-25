//
//  API.swift
//  NewsApp
//
//  Created by Vũ Linh on 24/06/2021.
//

import Foundation

enum APIError: Error {
    case noDataAvailable(String)
    case cannotProcessData(String)
    case requestFailed(String)
    case responseFailed(String)
}

class APIErrorKey {
    static var noData = "No data available"
    static var cannotProcessData = "Cannot Process Data"
    static var requestFail = "Request Fail"
    static var responseFail = "Response Fail"
}
