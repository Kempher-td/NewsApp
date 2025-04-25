//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 21.04.25.
//

import Foundation
import CoreData
import UIKit

final class CoreDataManager: BookmarkRepository {
    static let shared = CoreDataManager()

    private let context: NSManagedObjectContext

    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Could not access AppDelegate")
        }
        self.context = appDelegate.persistentContainer.viewContext
    }

    func add(_ article: Article) {
        var articleToSave = article
        articleToSave.isBookmarked = true 
        let entity = BookmarkEntity(context: context)
        entity.title = article.title
        entity.descriptionText = article.description
        entity.content = article.content
        entity.author = article.author
        entity.source = article.source
        entity.publishedAt = article.publishedAt
        entity.urlToImage = article.urlToImage

        do {
            try context.save()
        } catch {
            print("Failed to save bookmark: \(error)")
        }
    }

    func remove(_ article: Article) {
        let request: NSFetchRequest<BookmarkEntity> = BookmarkEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", article.title)

        do {
            let results = try context.fetch(request)
            results.forEach { context.delete($0) }
            try context.save()
        } catch {
            print("Failed to delete bookmark: \(error)")
        }
    }

    func isBookmarked(_ article: Article) -> Bool {
        let request: NSFetchRequest<BookmarkEntity> = BookmarkEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", article.title)

        do {
            return try context.count(for: request) > 0
        } catch {
            print("Failed to check bookmark: \(error)")
            return false
        }
    }

    func fetchBookmarks() -> [Article] {
        let request: NSFetchRequest<BookmarkEntity> = BookmarkEntity.fetchRequest()

        do {
            let entities = try context.fetch(request)
            return entities.map {
                Article(
                    title: $0.title ?? "",
                    description: $0.descriptionText ?? "",
                    content: $0.content ?? "",
                    author: $0.author,
                    source: $0.source ?? "",
                    publishedAt: $0.publishedAt ?? Date(),
                    urlToImage: $0.urlToImage
                )
            }
        } catch {
            print("Failed to fetch bookmarks: \(error)")
            return []
        }
    }
}


extension AppDelegate {
    var persistentContainer: NSPersistentContainer {
        let container = NSPersistentContainer(name: "NewsAppModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data load error: \(error)")
            }
        }
        return container
    }

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

