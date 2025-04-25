//
//  MockBookmarkRepository.swift
//  NewsAppTests
//
//  Created by Victor Mashukevich on 25.04.25.
//

import Foundation
@testable import NewsApp

final class MockBookmarkRepository: BookmarkRepository {
    private var bookmarks: [Article] = []
    
    func add(_ article: Article) {
        if !isBookmarked(article) {
            bookmarks.append(article)
        }
    }
    
    func remove(_ article: Article) {
        bookmarks.removeAll { $0.title == article.title }
    }
    
    func fetchBookmarks() -> [Article] {
        return bookmarks
    }
    
    func isBookmarked(_ article: Article) -> Bool {
        return bookmarks.contains { $0.title == article.title }
    }
}
