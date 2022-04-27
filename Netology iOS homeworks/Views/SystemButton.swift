//
//  SystemButton.swift
//  Netology iOS homeworks
//
//  Created by Александр on 16.01.2022.
//

import UIKit

class SystemButton: UIButton {

    typealias OnTapHandler = (() -> Void)

    // MARK: - Public Properties
    var onTapHandler: OnTapHandler? {
        didSet { connectButtonTappedFuncIfNeeded() }
    }

    // MARK: - Private Properties
    private var buttonTappedFuncWasConnected = false

    // MARK: - Initializers
    convenience init(title: String? = nil, titleColor: UIColor? = nil, onTapHandler: OnTapHandler? = nil) {
        self.init(type: .system)
        if let title = title {
            setTitle(title, for: .normal)
        }
        if let titleColor = titleColor {
            setTitleColor(titleColor, for: .normal)
        }
        if let onTapHandler = onTapHandler {
            self.onTapHandler = onTapHandler
            connectButtonTappedFuncIfNeeded()
        }
    }

    // MARK: - Private Methods
    @objc
    private func buttonTapped() {
        onTapHandler?()
    }

    private func connectButtonTappedFuncIfNeeded() {
        guard !buttonTappedFuncWasConnected else {
            return
        }
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        buttonTappedFuncWasConnected = true
    }
}
