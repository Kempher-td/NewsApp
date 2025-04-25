//
//  BookmarksController.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 18.04.25.
//


import UIKit
import CoreData

final class BookmarksViewController: UIViewController {
    
    private let viewModel: BookmarksViewModel
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 120
        return tv
    }()
    
    private let emptyStateView: EmptyStateView = {
        let view = EmptyStateView()
        view.isHidden = true
        return view
    }()
    
    init(viewModel: BookmarksViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Bookmarks"
        
        view.addSubview(tableView)
        view.addSubview(emptyStateView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    private func setupBindings() {
        viewModel.onBookmarksUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.emptyStateView.isHidden = !(self?.viewModel.bookmarks.isEmpty ?? true)
            }
        }
    }
    
    private func loadData() {
        viewModel.fetchBookmarks()
    }
}

extension BookmarksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsCell.identifier,
            for: indexPath
        ) as? NewsCell else {
            return UITableViewCell()
        }
        
        var article = viewModel.bookmarks[indexPath.row]
        article.isBookmarked = true
        cell.configure(with: article) { [weak self] in
            self?.viewModel.removeBookmark(article)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = viewModel.bookmarks[indexPath.row]
        let detailVC = NewsDetailViewController(
            article: article,
            viewModel: NewsViewModel(
                fetchNewsUseCase: GetNewsUseCaseImpl(repository: NewsRepositoryImpl(api: NewsAPIService())),
                toggleBookmarkUseCase: ToggleBookmarkUseCase(repository: CoreDataManager.shared)
            )
        )
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            guard let self = self else { return }
            let article = self.viewModel.bookmarks[indexPath.row]
            self.viewModel.removeBookmark(article)
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
