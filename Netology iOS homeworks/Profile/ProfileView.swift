//
//  ProfileView.swift
//  Netology iOS homeworks
//
//  Created by Александр on 22.08.2021.
//

import UIKit

class ProfileView: UIView {
    
    // MARK: - Private Properties
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 0
        return label
    }()
    
    private var birthdayLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        return label
    }()
    
    private var placeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        return label
    }()
    
    private var photoImageView: UIImageView = UIImageView()
    private var captionTextView: UITextView = UITextView()
    
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
        let mainStack = self.mainStack()
        addSubview(mainStack)
        photoImageView.setSquareAspectRatio(withHeight: 100)
        mainStack.constraintToSafeArea(safeAreaLayoutGuide, spacing: 20)
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
