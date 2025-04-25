//
//  RemoveBookmarkUseCase.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 22.04.25.
//

import Foundation

struct RemoveBookmarkUseCase {
    let repository: BookmarkRepository
    func execute(_ article: Article) {
        repository.remove(article)
    }
}
