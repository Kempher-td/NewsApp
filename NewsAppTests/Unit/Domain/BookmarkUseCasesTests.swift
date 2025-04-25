//
//  BookmarkUseCasesTests.swift
//  NewsAppTests
//
//  Created by Victor Mashukevich on 25.04.25.
//

import XCTest
@testable import NewsApp

final class BookmarkUseCasesTests: XCTestCase {
    private var mockRepository: BookmarkRepository!
    private var addBookmarkUseCase: AddBookmarkUseCase!
    private var removeBookmarkUseCase: RemoveBookmarkUseCase!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockBookmarkRepository()
        addBookmarkUseCase = AddBookmarkUseCase(repository: mockRepository)
        removeBookmarkUseCase = RemoveBookmarkUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        mockRepository = nil
        addBookmarkUseCase = nil
        removeBookmarkUseCase = nil
        super.tearDown()
    }
    
    func testAddBookmark() {
        
        let article = Article(
            title: "Test Title",
            description: "Test Description",
            content: "Test Content",
            author: "Test Author",
            source: "Test Source",
            publishedAt: Date(),
            urlToImage: "https://test.com/image.jpg"
        )
        
        addBookmarkUseCase.execute(article)
        
        XCTAssertTrue((mockRepository as! MockBookmarkRepository).isBookmarked(article))
        XCTAssertEqual((mockRepository as! MockBookmarkRepository).fetchBookmarks().count, 1)
        XCTAssertEqual((mockRepository as! MockBookmarkRepository).fetchBookmarks().first?.title, article.title)
    }
    
    func testRemoveBookmark() {
        
        let article = Article(
            title: "Test Title",
            description: "Test Description",
            content: "Test Content",
            author: "Test Author",
            source: "Test Source",
            publishedAt: Date(),
            urlToImage: "https://test.com/image.jpg"
        )
        addBookmarkUseCase.execute(article)
        XCTAssertTrue((mockRepository as! MockBookmarkRepository).isBookmarked(article))
        
        removeBookmarkUseCase.execute(article)
        
        XCTAssertFalse((mockRepository as! MockBookmarkRepository).isBookmarked(article))
        XCTAssertTrue((mockRepository as! MockBookmarkRepository).fetchBookmarks().isEmpty)
    }
}
