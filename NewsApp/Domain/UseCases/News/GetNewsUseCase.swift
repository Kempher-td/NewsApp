//
//  GetNewsUseCase.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 20.04.25.
//

protocol GetNewsUseCase {
    func execute(category: String, completion: @escaping (Result<[Article], Error>) -> Void)
}

final class GetNewsUseCaseImpl: GetNewsUseCase {
    private let repository: NewsRepository

    init(repository: NewsRepository) {
        self.repository = repository
    }

    func execute(category: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        repository.fetchTopHeadlines(category: category, completion: completion)
    }
}


