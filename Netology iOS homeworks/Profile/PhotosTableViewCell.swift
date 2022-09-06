//
//  PhotosTableViewCell.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 17.09.2021.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    var photos: [UIImage] = [] {
        didSet {
            updatePhotoStack()
        }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.text = "photosTitle".localized
        return label
    }()
    
    private lazy var forwardArrowImageView: UIImageView = {
        let image = UIImage(systemName: "arrow.forward")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var photosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.photosOffset
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        [titleLabel, forwardArrowImageView, photosStackView].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        [titleLabel, forwardArrowImageView, photosStackView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        let constraints: [NSLayoutConstraint] = [titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.defaultOffset),
                                                 titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.defaultOffset),
                                                 
                                                 forwardArrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
                                                 forwardArrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.defaultOffset),
                                                 
                                                 photosStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                                                 photosStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.defaultOffset),
                                                 photosStackView.trailingAnchor.constraint(equalTo: forwardArrowImageView.trailingAnchor),
                                                 photosStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.defaultOffset)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func updatePhotoStack() {
        photosStackView.removeAllArrangedSubviews()
        photos.forEach { photosStackView.addArrangedSubview(imageView(for: $0)) }
        var constraints: [NSLayoutConstraint] = []
        photosStackView.arrangedSubviews.forEach { photoView in
            photoView.translatesAutoresizingMaskIntoConstraints = false
            constraints.append(photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor))
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    private func imageView(for image: UIImage) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
}

extension PhotosTableViewCell {
    private struct Constants {
        static let defaultOffset: CGFloat = 12
        static let photosOffset: CGFloat = 8
    }
}
