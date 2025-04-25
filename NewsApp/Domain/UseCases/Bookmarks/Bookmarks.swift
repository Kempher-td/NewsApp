//
//  GetBookmarksUseCase.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 22.04.25.
//

import Foundation

struct ToggleBookmarkUseCase {
    private let repository: BookmarkRepository
    
    init(repository: BookmarkRepository) {
        self.repository = repository
    }
    
    func execute(article: Article) {
        if repository.isBookmarked(article) {
            repository.remove(article)
        } else {
            repository.add(article)
        }
    }
}

struct GetBookmarksUseCase {
    private let repository: BookmarkRepository
    
    init(repository: BookmarkRepository) {
        self.repository = repository
    }

    func execute() -> [Article] {
        return repository.fetchBookmarks()
    }
}
