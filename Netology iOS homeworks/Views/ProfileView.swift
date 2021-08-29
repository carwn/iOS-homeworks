//
//  ProfileView.swift
//  Netology iOS homeworks
//
//  Created by Александр on 22.08.2021.
//

import UIKit

class ProfileView: UIView {
    
    // MARK: - Private Properties
    private var photoImageView: UIImageView!
    private var nameLabel: UILabel!
    private var birthdayLabel: UILabel!
    private var placeLabel: UILabel!
    private var captionTextView: UITextView!
    
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
    func configure(name: String, birthday: String, place: String, photo: UIImage, caption: String) {
        nameLabel.text = name
        birthdayLabel.text = birthday
        placeLabel.text = place
        photoImageView.image = photo
        captionTextView.text = caption
    }
    
    // MARK: - Private Methods
    private func commonInit() {
        initSelfViews()
        let mainStack = self.mainStack()
        addSubview(mainStack)
        photoImageView.setSquareAspectRatio(withHeight: 100)
        mainStack.constraintToSafeArea(safeAreaLayoutGuide, spacing: 20)
    }
    
    private func initSelfViews() {
        nameLabel = UILabel()
        nameLabel.font = .preferredFont(forTextStyle: .title1)
        nameLabel.numberOfLines = 0
        
        birthdayLabel = UILabel()
        birthdayLabel.font = .preferredFont(forTextStyle: .title2)
        birthdayLabel.numberOfLines = 0
        
        placeLabel = UILabel()
        placeLabel.font = .preferredFont(forTextStyle: .title3)
        placeLabel.numberOfLines = 0
        
        [nameLabel, birthdayLabel, placeLabel].forEach { label in
            label!.setPriorities(contentHugging: 252, compressionResistance: 751)
        }
        
        photoImageView = UIImageView()
        photoImageView.setPriorities(compressionResistance: 748)
        
        captionTextView = UITextView()
        captionTextView.setPriorities(contentHugging: 249)
    }
    
    private func labelsStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [nameLabel, birthdayLabel, placeLabel])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }
    
    private func captionStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [photoImageView, labelsStack()])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }
    
    private func mainStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [captionStack(), captionTextView])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }
}
