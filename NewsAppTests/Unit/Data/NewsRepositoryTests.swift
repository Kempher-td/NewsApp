//
//  NewsRepositoryTests.swift
//  NewsAppTests
//
//  Created by Victor Mashukevich on 25.04.25.
//

import XCTest
@testable import NewsApp

final class MockNewsAPIService: NewsAPIServiceProtocol {
    var shouldSucceed = true
    var articles: [NewsResponseDTO.ArticleDTO] = []
    
    func getNews(category: String, completion: @escaping (Result<NewsResponseDTO, Error>) -> Void) {
        if shouldSucceed {
            completion(.success(NewsResponseDTO(articles: articles)))
        } else {
            completion(.failure(NSError(domain: "test", code: -1)))
        }
    }
}

final class NewsRepositoryTests: XCTestCase {
    var sut: NewsRepositoryImpl!
    var mockAPI: MockNewsAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPI = MockNewsAPIService()
        sut = NewsRepositoryImpl(api: mockAPI)
    }
    
    override func tearDown() {
        sut = nil
        mockAPI = nil
        super.tearDown()
    }
    
    func testFetchTopHeadlinesSuccess() {
        
        let expectation = XCTestExpectation(description: "Fetch headlines")
        let testDate = Date()
        let formatter = ISO8601DateFormatter()
        let dateString = formatter.string(from: testDate)
        
        mockAPI.articles = [
            NewsResponseDTO.ArticleDTO(
                title: "Test Title",
                description: "Test Description",
                content: "Test Content",
                author: "Test Author",
                source: SourceDTO(name: "Test Source"),
                publishedAt: dateString,
                urlToImage: "https://test.com/image.jpg"
            )
        ]

        sut.fetchTopHeadlines(category: "technology") { result in
            
            switch result {
            case .success(let articles):
                XCTAssertEqual(articles.count, 1)
                XCTAssertEqual(articles[0].title, "Test Title")
                XCTAssertEqual(articles[0].description, "Test Description")
                XCTAssertEqual(articles[0].content, "Test Content")
                XCTAssertEqual(articles[0].author, "Test Author")
                XCTAssertEqual(articles[0].source, "Test Source")
                XCTAssertEqual(articles[0].publishedAt, formatter.date(from: dateString))
                XCTAssertEqual(articles[0].urlToImage, "https://test.com/image.jpg")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchTopHeadlinesFailure() {
        
        let expectation = XCTestExpectation(description: "Fetch headlines failure")
        mockAPI.shouldSucceed = false
        
        sut.fetchTopHeadlines(category: "technology") { result in
            
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
