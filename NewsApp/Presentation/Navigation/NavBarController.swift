//
//  NavBarController.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 18.04.25.
//

import UIKit
import Foundation

final class NavbarController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        view.backgroundColor =  .white
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.fontNames(forFamilyName: "Helvetica")
        ]
    }
}
