//
//  NewsDTO.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 20.04.25.
//
import Foundation

struct NewsResponseDTO: Decodable {
    struct ArticleDTO: Decodable {
        let title: String
        let description: String?
        let content: String?
        let author: String?
        let source: SourceDTO
        let publishedAt: String
        let urlToImage: String?
    }
    let articles: [ArticleDTO]
}

struct SourceDTO: Decodable {
    let name: String
}
