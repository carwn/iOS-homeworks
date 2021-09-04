//
//  ProfileHeaderView.swift
//  Netology iOS homeworks
//
//  Created by Александр on 02.09.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private let imageViewHeight: CGFloat = 110
    
    private lazy var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = imageViewHeight / 2
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private lazy var showStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
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
    
    private func commonInit() {
        [avatarView, titleLabel, statusLabel, showStatusButton].forEach { addSubview($0) }
    }
    
    // MARK: - Public Methods
    func configure(image: UIImage, title: String, currentStatus: String?) {
        avatarView.image = image
        titleLabel.text = title
        statusLabel.text = currentStatus ?? "Waiting for something..."
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        let defaulOffset: CGFloat = 16
        let buttonVerticalOffset = defaulOffset * 2 + imageViewHeight + safeAreaInsets.top
        let labelsHorizontalOffset = defaulOffset * 2 + imageViewHeight + safeAreaInsets.left
        let labelsWidth = bounds.width - labelsHorizontalOffset - defaulOffset - safeAreaInsets.right
        let statusLabelHeight = statusLabel.intrinsicContentSize.height
        
        avatarView.frame = CGRect(x: defaulOffset + safeAreaInsets.left,
                                  y: defaulOffset + safeAreaInsets.top,
                                  width: imageViewHeight,
                                  height: imageViewHeight)
        
        showStatusButton.frame = CGRect(x: defaulOffset + safeAreaInsets.left,
                                        y: buttonVerticalOffset,
                                        width: bounds.width - defaulOffset * 2 - safeAreaInsets.left - safeAreaInsets.right,
                                        height: 50)
        
        titleLabel.frame = CGRect(x: labelsHorizontalOffset,
                                  y: 27 + safeAreaInsets.top,
                                  width: labelsWidth,
                                  height: titleLabel.intrinsicContentSize.height)
        
        
        statusLabel.frame = CGRect(x: labelsHorizontalOffset,
                                   y: buttonVerticalOffset - 34 - statusLabelHeight,
                                   width: labelsWidth,
                                   height: statusLabelHeight)
    }
}
