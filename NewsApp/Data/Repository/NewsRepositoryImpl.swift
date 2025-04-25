//
//  NewsRepositoryImpl.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 20.04.25.
//

import Foundation

protocol NewsRepository {
    func fetchTopHeadlines(category: String, completion: @escaping (Result<[Article], Error>) -> Void)
}

final class NewsRepositoryImpl: NewsRepository {
    private let api: NewsAPIServiceProtocol

    init(api: NewsAPIServiceProtocol) {
        self.api = api
    }

    func fetchTopHeadlines(category: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        api.getNews(category: category) { result in
            switch result {
            case .success(let dto):
                let articles = dto.articles.map { $0.toDomain() }
                completion(.success(articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


