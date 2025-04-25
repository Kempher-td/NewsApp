//
//  BookmarkRepositoryTests.swift
//  NewsAppTests
//
//  Created by Victor Mashukevich on 25.04.25.
//

import XCTest
@testable import NewsApp

final class BookmarkRepositoryTests: XCTestCase {
    var sut: BookmarkRepository!
    
    override func setUp() {
        super.setUp()
        
        sut = MockBookmarkRepository()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testAddAndFetchBookmark() {
        
        let article = Article(
            title: "Test Title",
            description: "Test Description",
            content: "Test Content",
            author: "Test Author",
            source: "Test Source",
            publishedAt: Date(),
            urlToImage: "https://test.com/image.jpg"
        )
        
        sut.add(article)
        let bookmarks = sut.fetchBookmarks()
        
        XCTAssertEqual(bookmarks.count, 1)
        XCTAssertEqual(bookmarks.first?.title, article.title)
        XCTAssertTrue(sut.isBookmarked(article))
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
        sut.add(article)

        sut.remove(article)

        XCTAssertTrue(sut.fetchBookmarks().isEmpty)
        XCTAssertFalse(sut.isBookmarked(article))
    }
    
    func testIsBookmarkedReturnsFalseForNonBookmarkedArticle() {
        
        let article = Article(
            title: "Test Title",
            description: "Test Description",
            content: "Test Content",
            author: "Test Author",
            source: "Test Source",
            publishedAt: Date(),
            urlToImage: "https://test.com/image.jpg"
        )
        
        XCTAssertFalse(sut.isBookmarked(article))
    }
}
