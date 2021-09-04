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
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set status", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(setStatusButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private var statusText: String?
    
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
        [avatarView, titleLabel, statusLabel, setStatusButton, statusTextField].forEach { addSubview($0) }
    }
    
    // MARK: - Public Methods
    func configure(image: UIImage, title: String, currentStatus: String?) {
        avatarView.image = image
        titleLabel.text = title
        statusText = currentStatus
        updateStatusLabel()
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        let defaulOffset: CGFloat = 16
        let statusViewsOffset: CGFloat = 10
        let statusTextFieldHeight: CGFloat = 40
        
        let oldButtonVerticalOffset = defaulOffset * 2 + imageViewHeight + safeAreaInsets.top
        let statusLabelHeight = statusLabel.intrinsicContentSize.height
        let statusLabelVerticalOffset = oldButtonVerticalOffset - 34 - statusLabelHeight
        let statusTextFieldVerticalOffset = statusLabelVerticalOffset + statusLabelHeight + statusViewsOffset
        
        let labelsHorizontalOffset = defaulOffset * 2 + imageViewHeight + safeAreaInsets.left
        let labelsWidth = bounds.width - labelsHorizontalOffset - defaulOffset - safeAreaInsets.right
        
        
        avatarView.frame = CGRect(x: defaulOffset + safeAreaInsets.left,
                                  y: defaulOffset + safeAreaInsets.top,
                                  width: imageViewHeight,
                                  height: imageViewHeight)
        
        titleLabel.frame = CGRect(x: labelsHorizontalOffset,
                                  y: 27 + safeAreaInsets.top,
                                  width: labelsWidth,
                                  height: titleLabel.intrinsicContentSize.height)
        
        statusLabel.frame = CGRect(x: labelsHorizontalOffset,
                                   y: statusLabelVerticalOffset,
                                   width: labelsWidth,
                                   height: statusLabelHeight)
        
        statusTextField.frame = CGRect(x: labelsHorizontalOffset,
                                       y: statusTextFieldVerticalOffset,
                                       width: labelsWidth,
                                       height: statusTextFieldHeight)
        
        setStatusButton.frame = CGRect(x: defaulOffset + safeAreaInsets.left,
                                        y: statusTextFieldVerticalOffset + statusTextFieldHeight + defaulOffset,
                                        width: bounds.width - defaulOffset * 2 - safeAreaInsets.left - safeAreaInsets.right,
                                        height: 50)
    }
    
    // MARK: - Private Methods
    
    @objc private func setStatusButtonPressed() {
        updateStatusLabel()
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text
    }
    
    private func updateStatusLabel() {
        let statusTextForLabel: String = {
            let placeholder = "Waiting for something..."
            if let statusText = statusText {
                return statusText.isEmpty ? placeholder : statusText
            } else {
                return placeholder
            }
        }()
        statusLabel.text = statusTextForLabel
    }
}
