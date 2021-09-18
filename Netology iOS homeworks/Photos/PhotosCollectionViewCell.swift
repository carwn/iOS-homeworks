//
//  PhotosCollectionViewCell.swift
//  Netology iOS homeworks
//
//  Created by Александр on 18.09.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Public Methods
    
    func configure(image: UIImage) {
        photoImageView.image = image
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        contentView.addSubview(photoImageView)
    }
    
    private func setupConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                                 photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                                 photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                                 photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
}
