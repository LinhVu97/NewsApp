//
//  News.swift
//  NewsApp
//
//  Created by Vũ Linh on 25/06/2021.
//

import Foundation

struct Posts: Codable {
    var posts: [News]
}

struct News: Codable {
    var thread: NewsDetail
    var author: String?
    var text: String?
    var url: String
    var title: String
    var published: String?
}

struct NewsDetail: Codable {
    var mainImage: String?
    
    enum CodingKeys: String, CodingKey {
        case mainImage = "main_image"
    }
}
