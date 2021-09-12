//
//  LogInViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 11.09.2021.
//

import UIKit

class LogInViewController: UIViewController {
    
    private let textFieldsViewBorderWidth: CGFloat = 0.5
    private let textFieldsViewBorderColor: UIColor = .lightGray
    
    private let mainScrollView = UIScrollView()
    private let scrollViewContentView = UIView()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"), highlightedImage: nil)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textFieldsView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.borderColor = textFieldsViewBorderColor.cgColor
        view.layer.borderWidth = textFieldsViewBorderWidth
        view.layer.masksToBounds = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var textFieldsViewSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = textFieldsViewBorderColor
        return view
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        setupTextField(textField)
        textField.placeholder = "Email or phone"
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        setupTextField(textField)
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private func setupTextField(_ textField: UITextField) {
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor(named: "AccentColor")
        textField.autocapitalizationType = .none
    }
    
    private var logInButton: UIButton = {
        let button = UIButton()
        let bluePixelImage = UIImage(named: "blue_pixel")
        button.setBackgroundImage(bluePixelImage, for: .normal)
        let bluePixelImageWithAlpha80 = bluePixelImage?.withAlpha(0.8)
        button.setBackgroundImage(bluePixelImageWithAlpha80, for: .selected)
        button.setBackgroundImage(bluePixelImageWithAlpha80, for: .highlighted)
        button.setBackgroundImage(bluePixelImageWithAlpha80, for: .disabled)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.masksToBounds = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainScrollView)
        scrollViewContentView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.addSubview(scrollViewContentView)
        [logoImageView, textFieldsView, logInButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            scrollViewContentView.addSubview(view)
        }
        [loginTextField, passwordTextField, textFieldsViewSeparator].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            textFieldsView.addSubview(view)
        }
    }
    
    private func setupConstraints() {
        let logoOffset: CGFloat = 120
        let logoSize: CGFloat = 100
        let defaultOffset: CGFloat = 16
        let constraints = [mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: defaultOffset),
                           mainScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: defaultOffset),
                           mainScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -defaultOffset),
                           mainScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -defaultOffset),
                           
                           scrollViewContentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
                           scrollViewContentView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
                           scrollViewContentView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
                           scrollViewContentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
                           
                           scrollViewContentView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor),
                           
                           logoImageView.topAnchor.constraint(equalTo: scrollViewContentView.topAnchor, constant: logoOffset),
                           logoImageView.centerXAnchor.constraint(equalTo: scrollViewContentView.centerXAnchor),
                           logoImageView.heightAnchor.constraint(equalToConstant: logoSize),
                           logoImageView.widthAnchor.constraint(equalToConstant: logoSize),
                           
                           textFieldsView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: logoOffset),
                           textFieldsView.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor),
                           textFieldsView.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor),
                           textFieldsView.heightAnchor.constraint(equalToConstant: 100),
                           
                           loginTextField.topAnchor.constraint(equalTo: textFieldsView.topAnchor),
                           loginTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor, constant: defaultOffset),
                           loginTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor, constant: -defaultOffset),
                           loginTextField.bottomAnchor.constraint(equalTo: textFieldsView.centerYAnchor),
                           
                           passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
                           passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
                           passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
                           passwordTextField.bottomAnchor.constraint(equalTo: textFieldsView.bottomAnchor),
                           
                           textFieldsViewSeparator.heightAnchor.constraint(equalToConstant: textFieldsViewBorderWidth),
                           textFieldsViewSeparator.centerYAnchor.constraint(equalTo: textFieldsView.centerYAnchor),
                           textFieldsViewSeparator.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor),
                           textFieldsViewSeparator.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor),
                           
                           logInButton.topAnchor.constraint(equalTo: textFieldsView.bottomAnchor, constant: defaultOffset),
                           logInButton.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor),
                           logInButton.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor),
                           logInButton.heightAnchor.constraint(equalToConstant: 50),
                           logInButton.bottomAnchor.constraint(lessThanOrEqualTo: scrollViewContentView.bottomAnchor, constant: -defaultOffset)]
        NSLayoutConstraint.activate(constraints)
    }
}
