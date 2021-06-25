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
}

struct NewsDetail: Codable {
    var url: String
    var title: String
    var published: String?
    var main_image: String?
    var author: String?
    var text: String?
}
