//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 22.04.25.
//

import Foundation

final class NewsDetailViewModel {
    
    private let toggleBookmarkUseCase: ToggleBookmarkUseCase
    private let isBookmarkedUseCase: GetBookmarksUseCase 
    
    let article: Article
    @Published var isBookmarked: Bool = false
    
    init(
        article: Article,
        toggleBookmarkUseCase: ToggleBookmarkUseCase,
        isBookmarkedUseCase: GetBookmarksUseCase
    ) {
        self.article = article
        self.toggleBookmarkUseCase = toggleBookmarkUseCase
        self.isBookmarkedUseCase = isBookmarkedUseCase
        checkBookmarkStatus()
    }
    
    func toggleBookmark() {
        toggleBookmarkUseCase.execute(article: article)
        isBookmarked.toggle()
    }
    
    private func checkBookmarkStatus() {
        isBookmarked = isBookmarkedUseCase.execute().contains { $0.title == article.title }
    }
}

