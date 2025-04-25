//
//  ToggleBookmarkUseCase.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 21.04.25.
//

import Foundation

struct AddBookmarkUseCase {
    let repository: BookmarkRepository
    func execute(_ article: Article) {
        repository.add(article)
    }
}
