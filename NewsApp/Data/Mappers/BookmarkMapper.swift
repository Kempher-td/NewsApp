//
//  BookmarkMapper.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 22.04.25.
//

import Foundation
import CoreData

final class BookmarkMapper {
    static func toDomain(from entity: BookmarkEntity) -> Article {
        return Article(
            title: entity.title ?? "",
            description: entity.descriptionText ?? "",
            content: entity.content ?? "",
            author: entity.author,
            source: entity.source ?? "",
            publishedAt: entity.publishedAt ?? Date(),
            urlToImage: entity.urlToImage
        )
    }

    static func toEntity(from article: Article, context: NSManagedObjectContext) -> BookmarkEntity {
        let entity = BookmarkEntity(context: context)
        entity.title = article.title
        entity.descriptionText = article.description
        entity.content = article.content
        entity.author = article.author
        entity.source = article.source
        entity.publishedAt = article.publishedAt
        entity.urlToImage = article.urlToImage
        return entity
    }
}
