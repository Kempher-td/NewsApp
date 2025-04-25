//
//  Article.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 19.04.25.
//
import Foundation

struct Article {
    let title: String
    let description: String
    let content: String
    let author: String?
    let source: String
    let publishedAt: Date
    let urlToImage: String?
    var isBookmarked: Bool = false
}
