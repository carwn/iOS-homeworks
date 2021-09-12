//
//  PostTableViewCell.swift
//  Netology iOS homeworks
//
//  Created by Александр on 12.09.2021.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Public Properties
    var post: Post? {
        didSet {
            updateFromPost()
        }
    }
    
    // MARK: - Private Properties
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Initializers
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        [authorLabel, postImageView, descriptionLabel, likesLabel, viewsLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(view)
        }
        descriptionLabel.setContentHuggingPriority(.required, for: .vertical)
        descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        let defaultOffset: CGFloat = 16
        let constraints = [authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultOffset),
                           authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: defaultOffset),
                           authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultOffset),
        
                           postImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                           postImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                           postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
                           postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
        
                           descriptionLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
                           descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: defaultOffset),
                           descriptionLabel.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),
        
                           likesLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
                           likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: defaultOffset),
                           likesLabel.trailingAnchor.constraint(lessThanOrEqualTo: viewsLabel.leadingAnchor, constant: -defaultOffset),
                           likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -defaultOffset),
        
                           viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: defaultOffset),
                           viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultOffset),
                           viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -defaultOffset)]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func updateFromPost() {
        guard let post = post else {
            updateView(withAuthor: nil, imageName: nil, description: nil, likes: nil, views: nil)
            return
        }
        updateView(withAuthor: post.author, imageName: post.image, description: post.description, likes: post.likes, views: post.views)
    }
    
    private func updateView(withAuthor author: String?, imageName: String?, description: String?, likes: Int?, views: Int?) {
        authorLabel.text = author ?? "No author"
        postImageView.image = imageName != nil ? UIImage(named: imageName!) : nil
        descriptionLabel.text = description
        likesLabel.text = "Likes: \(likes?.description ?? "-")"
        viewsLabel.text = "Views: \(views?.description ?? "-")"
    }
}
