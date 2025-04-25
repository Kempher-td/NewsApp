//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 18.04.25.
//

import UIKit
import CoreData
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
           AppSettings.applyTheme()
           setupGlobalAppearance()
           return true
    }

    private func setupGlobalAppearance() {
        UINavigationBar.appearance().tintColor = .systemBlue
        UITableView.appearance().backgroundColor = .clear
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

 

}

