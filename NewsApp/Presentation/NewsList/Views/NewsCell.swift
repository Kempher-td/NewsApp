//
//  NewsCell.swift
//  NewsApp
//
//  Created by Victor Mashukevich on 22.04.25.
//

import Foundation
import UIKit

final class NewsCell: UITableViewCell {
    static let identifier = "NewsCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 3
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        button.tintColor = .gray 
        button.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let newsImageView: UIImageView = {
           let iv = UIImageView()
           iv.contentMode = .scaleAspectFill
           iv.clipsToBounds = true
           iv.layer.cornerRadius = 8
           iv.contentMode = .scaleAspectFill
           iv.backgroundColor = .systemGray5
           iv.isUserInteractionEnabled = true 
           return iv
       }()
    private var bookmarkAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func prepareForReuse() {
          super.prepareForReuse()
          
          newsImageView.image = nil
          titleLabel.text = nil
          descriptionLabel.text = nil
          sourceLabel.text = nil
          bookmarkButton.isSelected = false
          bookmarkAction = nil
          
          newsImageView.isHidden = false
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with article: Article, bookmarkAction: @escaping () -> Void) {
           titleLabel.text = article.title
           descriptionLabel.text = article.description
           sourceLabel.text = article.source
        
           if let imageUrl = article.urlToImage {
                  loadImage(from: imageUrl)
              }
           bookmarkButton.isSelected = article.isBookmarked
           bookmarkButton.tintColor = article.isBookmarked ? .systemBlue : .gray
           self.bookmarkAction = bookmarkAction
       }
 
    private func loadImage(from urlString: String) {
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    
    private func setupUI() {
        
            selectionStyle = .none

            contentView.addSubview(newsImageView)
            contentView.addSubview(titleLabel)
            contentView.addSubview(descriptionLabel)
            contentView.addSubview(sourceLabel)
            newsImageView.addSubview(bookmarkButton)

            newsImageView.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            sourceLabel.translatesAutoresizingMaskIntoConstraints = false
            bookmarkButton.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                newsImageView.heightAnchor.constraint(equalToConstant: 180),

                bookmarkButton.topAnchor.constraint(equalTo: newsImageView.topAnchor, constant: 8),
                bookmarkButton.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: -8),
                bookmarkButton.widthAnchor.constraint(equalToConstant: 24),
                bookmarkButton.heightAnchor.constraint(equalToConstant: 24),

                titleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 12),
                titleLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor),

                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                descriptionLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor),

                sourceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
                sourceLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor),
                sourceLabel.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor),
                sourceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
            ])
        }
    
    @objc private func bookmarkButtonTapped() {
           bookmarkButton.isSelected.toggle()
           bookmarkButton.tintColor = bookmarkButton.isSelected ? .systemBlue : .gray
           bookmarkAction?()
       }
}
