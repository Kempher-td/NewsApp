//
//  BookmarksViewModel.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 18.04.25.
//

import Foundation

final class BookmarksViewModel {
    
    private let getBookmarksUseCase: GetBookmarksUseCase
    private let removeBookmarkUseCase: RemoveBookmarkUseCase
    
    var onBookmarksUpdated: (() -> Void)?
    
    private(set) var bookmarks: [Article] = []
    
    init(
        getBookmarksUseCase: GetBookmarksUseCase,
        removeBookmarkUseCase: RemoveBookmarkUseCase
    ) {
        self.getBookmarksUseCase = getBookmarksUseCase
        self.removeBookmarkUseCase = removeBookmarkUseCase
    }
    
    func fetchBookmarks() {
        bookmarks = getBookmarksUseCase.execute()
        onBookmarksUpdated?()
    }
    
    func removeBookmark(_ article: Article) {
        removeBookmarkUseCase.execute(article)
        fetchBookmarks() 
    }
}
