//
//  SettingsController.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 18.04.25.
//

import Foundation
import UIKit

final class SettingsController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let appearanceOptions: [(name: String, style: UIUserInterfaceStyle)] = [
        ("System Default", .unspecified),
        ("Light Mode", .light),
        ("Dark Mode", .dark)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Settings"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension SettingsController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "APPEARANCE" : "ABOUT"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? appearanceOptions.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .secondarySystemBackground
        
        if indexPath.section == 0 {
            let option = appearanceOptions[indexPath.row]
            cell.textLabel?.text = option.name
            cell.accessoryType = AppSettings.currentTheme == option.style ? .checkmark : .none
        } else {
            cell.textLabel?.text = "About the App"
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            handleThemeSelection(at: indexPath)
        } else {
            showDeveloperInfo()
        }
    }
    
    private func handleThemeSelection(at indexPath: IndexPath) {
        let selectedStyle = appearanceOptions[indexPath.row].style
        AppSettings.currentTheme = selectedStyle
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
        
        UIView.transition(with: view.window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
            AppSettings.applyTheme()
        })
    }
    
    private func showDeveloperInfo() {
        let alert = UIAlertController(
            title: "Developer",
            message: "Victor Mashukevich\nVersion 1.0",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

