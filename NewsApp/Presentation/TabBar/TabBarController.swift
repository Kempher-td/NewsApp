//
//  TabBarController.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 18.04.25.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupAppearance()
    }
    
    private func setupAppearance() {
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = .systemBackground
    }
    private func setupViewControllers(){
        let apiService = NewsAPIService()
        let newsRepository = NewsRepositoryImpl(api: apiService)
        let coreDataManager = CoreDataManager.shared
        
        let newsVM = NewsViewModel(
            fetchNewsUseCase: GetNewsUseCaseImpl(repository: newsRepository),
            toggleBookmarkUseCase: ToggleBookmarkUseCase(repository: coreDataManager)
        )
        
        let bookmarksVM = BookmarksViewModel(
            getBookmarksUseCase: GetBookmarksUseCase(repository: coreDataManager),
            removeBookmarkUseCase: RemoveBookmarkUseCase(repository: coreDataManager)
        )
        
        let newsVC = NewsListController(viewModel: newsVM)
        let bookmarksVC = BookmarksViewController(viewModel: bookmarksVM)
        let settingsVC = SettingsController()
        
        newsVC.tabBarItem = UITabBarItem(
            title: "News",
            image: UIImage(systemName: "newspaper"),
            selectedImage: UIImage(systemName: "newspaper.fill")
        )
        
        bookmarksVC.tabBarItem = UITabBarItem(
            title: "Bookmarks",
            image: UIImage(systemName: "bookmark"),
            selectedImage: UIImage(systemName: "bookmark.fill")
        )
        settingsVC.tabBarItem = UITabBarItem (
            title: "Settings",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill"))
        
    
        let nav1 = UINavigationController(rootViewController: newsVC)
        let nav2 = UINavigationController(rootViewController: bookmarksVC)
        let nav3 = UINavigationController(rootViewController: settingsVC)
        
        viewControllers = [nav1, nav2, nav3]
    }
}
