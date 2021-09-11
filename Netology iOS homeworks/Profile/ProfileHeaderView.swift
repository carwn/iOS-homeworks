//
//  ProfileHeaderView.swift
//  Netology iOS homeworks
//
//  Created by Александр on 02.09.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private let avatarImageViewHeight: CGFloat = 110
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = avatarImageViewHeight / 2
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
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
        [avatarImageView, fullNameLabel, statusLabel, setStatusButton, statusTextField].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
        let defaulOffset: CGFloat = 16
        let constraints = [avatarImageView.heightAnchor.constraint(equalToConstant: avatarImageViewHeight),
                           avatarImageView.widthAnchor.constraint(equalToConstant: avatarImageViewHeight),
                           
                           avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: defaulOffset),
                           avatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: defaulOffset),
                           
                           fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
                           fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: defaulOffset),
                           fullNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -defaulOffset),
                           
                           statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
                           statusLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
                           statusLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -18),
                           
                           statusTextField.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
                           statusTextField.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
                           statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
                           
                           statusTextField.heightAnchor.constraint(equalToConstant: 40),
                           
                           setStatusButton.heightAnchor.constraint(equalToConstant: 50),
                           
                           setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: defaulOffset),
                           setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -defaulOffset),
                           setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: defaulOffset)]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Public Methods
    func configure(image: UIImage, title: String, currentStatus: String?) {
        avatarImageView.image = image
        fullNameLabel.text = title
        statusText = currentStatus
        updateStatusLabel()
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
            if let statusText = statusText, !statusText.isEmpty {
                return statusText
            } else {
                return "Waiting for something..."
            }
        }()
        statusLabel.text = statusTextForLabel
    }
}
