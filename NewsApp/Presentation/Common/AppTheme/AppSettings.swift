//
//  AppSettings.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 23.04.25.
//

import Foundation
import UIKit

final class AppSettings {
    private static let themeKey = "appTheme"
    
    static var currentTheme: UIUserInterfaceStyle {
        get {
            let savedValue = UserDefaults.standard.string(forKey: themeKey) ?? "unspecified"
            switch savedValue {
            case "light": return .light
            case "dark": return .dark
            default: return .unspecified
            }
        }
        set {
            let value: String
            switch newValue {
            case .light: value = "light"
            case .dark: value = "dark"
            default: value = "unspecified"
            }
            UserDefaults.standard.set(value, forKey: themeKey)
            applyTheme()
        }
    }
    
    static func applyTheme() {
        DispatchQueue.main.async {
            UIApplication.shared.windows.forEach { window in
                UIView.transition(
                    with: window,
                    duration: 0.3,
                    options: .transitionCrossDissolve,
                    animations: {
                        window.overrideUserInterfaceStyle = currentTheme
                    }
                )
            }
        }
    }
}
