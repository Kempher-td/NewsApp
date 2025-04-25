//
//  GetNewsUseCaseTests.swift
//  NewsAppTests
//
//  Created by Victor Mashukevich on 25.04.25.
//

import Foundation
import XCTest
@testable import NewsApp

final class MockNewsRepository: NewsRepository {
    var result: Result<[Article], Error>?
    
    func fetchTopHeadlines(category: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}

final class GetNewsUseCaseTests: XCTestCase {
    var sut: GetNewsUseCase!
    var mockRepository: MockNewsRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockNewsRepository()
        sut = GetNewsUseCaseImpl(repository: mockRepository)
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testExecuteSuccess() {
        
        let expectation = XCTestExpectation(description: "Fetch news")
        let testArticles = [
            Article(
                title: "Test Title",
                description: "Test Description",
                content: "Test Content",
                author: "Test Author",
                source: "Test Source",
                publishedAt: Date(),
                urlToImage: "https://test.com/image.jpg"
            )
        ]
        mockRepository.result = .success(testArticles)
        
        sut.execute(category: "technology") { result in
            
            switch result {
            case .success(let articles):
                XCTAssertEqual(articles.count, 1)
                XCTAssertEqual(articles[0].title, "Test Title")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testExecuteFailure() {
        
        let expectation = XCTestExpectation(description: "Fetch news failure")
        let testError = NSError(domain: "test", code: -1)
        mockRepository.result = .failure(testError)
        
        sut.execute(category: "technology") { result in
            
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "test")
                XCTAssertEqual((error as NSError).code, -1)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
