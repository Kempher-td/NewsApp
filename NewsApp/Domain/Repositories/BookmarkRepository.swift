//
//  BookmarkRepository.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 21.04.25.
//

import Foundation

protocol BookmarkRepository {
    func add(_ article: Article)
    func remove(_ article: Article)
    func fetchBookmarks() -> [Article]
    func isBookmarked(_ article: Article) -> Bool
}
