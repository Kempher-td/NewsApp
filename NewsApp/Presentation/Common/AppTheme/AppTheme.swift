//
//  AppTheme.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 23.04.25.
//

import Foundation
import UIKit

enum AppTheme: String, CaseIterable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
    
    var displayName: String { rawValue }
    
    var interfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .system: return .unspecified
        case .light: return .light
        case .dark: return .dark
        }
    }
}
