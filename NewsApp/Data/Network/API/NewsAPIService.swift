//
//  NewsAPIService.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 19.04.25.
//

import Foundation


protocol NewsAPIServiceProtocol {
    func getNews(category: String, completion: @escaping (Result<NewsResponseDTO, Error>) -> Void)
}

final class NewsAPIService: NewsAPIServiceProtocol {
    private let apiKey = "963888c6c3de46a78fde1540963bf6dd"
    private let baseURL = "https://newsapi.org/v2/top-headlines?country=us"

    func getNews(category: String, completion: @escaping (Result<NewsResponseDTO, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)&category=\(category)&apiKey=\(apiKey)") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(NewsResponseDTO.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


