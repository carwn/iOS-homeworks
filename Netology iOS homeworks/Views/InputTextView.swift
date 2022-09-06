//
//  InputTextView.swift
//  Netology iOS homeworks
//
//  Created by Александр on 16.01.2022.
//

import UIKit

protocol InputTextViewDelegate: AnyObject {
    func userInputedText(text: String?)
}

class InputTextView: UIView {

    // MARK: - Public Properties
    weak var delegate: InputTextViewDelegate?

    // MARK: - Private Properties
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "inputTextPlaceholder".localized
        return textField
    }()

    private lazy var sendButton: UIButton = {
        SystemButton(title: "sendButtonTitle".localized) { [weak self] in
            self?.sendButtonPressed()
        }
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        sendButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        sendButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        addSubview(textField)
        addSubview(sendButton)
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.horizontalOffset)
            make.top.equalToSuperview().offset(Constants.verticalOffset)
            make.bottom.equalToSuperview().offset(-Constants.verticalOffset)
        }
        sendButton.snp.makeConstraints { make in
            make.leading.equalTo(textField.snp_trailingMargin).offset(Constants.viewsOffset)
            make.top.equalToSuperview().offset(Constants.verticalOffset)
            make.trailing.equalToSuperview().offset(-Constants.horizontalOffset)
            make.bottom.equalToSuperview().offset(-Constants.verticalOffset)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.height, bounds.width) * Constants.cornerRadiusMultiplier
    }

    // MARK: - Private Methods
    func sendButtonPressed() {
        delegate?.userInputedText(text: textField.text)
    }
}

extension InputTextView {
    struct Constants {
        static let horizontalOffset: CGFloat = 8
        static let verticalOffset: CGFloat = 4
        static let viewsOffset: CGFloat = 16
        static let cornerRadiusMultiplier = 0.3
    }
}
