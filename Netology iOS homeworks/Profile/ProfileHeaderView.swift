//
//  ProfileHeaderView.swift
//  Netology iOS homeworks
//
//  Created by Александр on 02.09.2021.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    // MARK: - Public Properties
    
    var avatarViewTappedClosure: (((avatarView: UIView, backgroundView: UIView)) -> Void)?
    
    // MARK: - Private Properties
    
    private let avatarImageViewHeight: CGFloat = 110
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .purple
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = avatarImageViewHeight / 2
        imageView.clipsToBounds = true
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(avatarImageTapAction)))
        
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
    
    private lazy var setStatusButton: SystemButton = {
        let button = SystemButton(title: "Set status", titleColor: .white) { [weak self] in
            self?.setStatusButtonPressed()
        }
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
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
    
    private let avatarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.opacity = 0
        return view
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
        [fullNameLabel, statusLabel, setStatusButton, statusTextField, avatarBackgroundView, avatarImageView].forEach { view in
            self.addSubview(view)
        }
        
        let defaulOffset: CGFloat = 16

        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: avatarImageViewHeight, height: avatarImageViewHeight))
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(defaulOffset)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(defaulOffset)
        }

        fullNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(27)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(defaulOffset)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-defaulOffset)
        }

        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(fullNameLabel)
            make.trailing.equalTo(fullNameLabel)
            make.bottom.equalTo(avatarImageView).offset(-18)
        }

        statusTextField.snp.makeConstraints { make in
            make.leading.equalTo(fullNameLabel)
            make.trailing.equalTo(fullNameLabel)
            make.top.equalTo(statusLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
        }

        setStatusButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(defaulOffset)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-defaulOffset)
            make.top.equalTo(statusTextField.snp.bottom).offset(defaulOffset)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-defaulOffset)
        }
    }
    
    // MARK: - Public Methods
    func configure(image: UIImage?, title: String, currentStatus: String?) {
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
    
    @objc private func avatarImageTapAction() {
        avatarViewTappedClosure?((avatarView: avatarImageView, backgroundView: avatarBackgroundView))
    }
}
