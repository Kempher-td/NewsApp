//
//  NewsMapper.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 20.04.25.
//

import Foundation
extension NewsResponseDTO.ArticleDTO {
    func toDomain() -> Article {
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: publishedAt) ?? Date()
        return Article(
            title: title,
            description: description ?? "",
            content: content ?? "",
            author: author,
            source: source.name,
            publishedAt: date,
            urlToImage: urlToImage,
            isBookmarked: false
        )
    }
}
