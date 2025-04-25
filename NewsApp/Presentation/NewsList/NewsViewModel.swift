//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 20.04.25.
//

import Foundation

final class NewsViewModel {
    
    private let fetchNewsUseCase: GetNewsUseCase
    private let toggleBookmarkUseCase: ToggleBookmarkUseCase
    
    var onArticlesUpdated: (() -> Void)?
    var onErrorMessage: ((String) -> Void)?
    
    private(set) var articles: [Article] = []
    private(set) var selectedCategory = "general"
    let categories = ["general", "business", "technology", "sports"]
    
    init(
        fetchNewsUseCase: GetNewsUseCase,
        toggleBookmarkUseCase: ToggleBookmarkUseCase
    ) {
        self.fetchNewsUseCase = fetchNewsUseCase
        self.toggleBookmarkUseCase = toggleBookmarkUseCase
    }
    
    func fetchArticles(for category: String) {
        selectedCategory = category
        fetchNewsUseCase.execute(category: category) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.onArticlesUpdated?()
            case .failure(let error):
                if (error as? URLError)?.code == .notConnectedToInternet{
                    self?.onErrorMessage?("No internet connection")
                }else {
                    self?.onErrorMessage?("Failed to load data")
                }
            }
        }
    }
    
    func toggleBookmark(for article: Article) {
        if let index = articles.firstIndex(where: { $0.title == article.title }) {
            articles[index].isBookmarked.toggle()
            toggleBookmarkUseCase.execute(article: articles[index])
            onArticlesUpdated?()
        }
    }
}
