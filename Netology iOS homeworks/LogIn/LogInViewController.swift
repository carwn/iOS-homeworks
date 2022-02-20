//
//  LogInViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 11.09.2021.
//

import UIKit

class LogInViewController: UIViewController {
    
    // MARK: - Private Properties
    private let presenter: LoginViewOutput

    // MARK: - Initializers

    init(presenter: LoginViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subviews
    
    private let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    private let scrollViewContentView = UIView()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let textFieldsViewBorderWidth: CGFloat = 0.5
    private let textFieldsViewBorderColor: UIColor = .lightGray
    
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
        textField.delegate = self
#if DEBUG
        textField.text = "Hipster Cat"
#endif
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        setupTextField(textField)
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.delegate = self
#if DEBUG
        textField.text = "StrongPassword"
#endif
        return textField
    }()
    
    private func setupTextField(_ textField: UITextField) {
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor(named: "AccentColor")
        textField.autocapitalizationType = .none
    }
    
    private lazy var logInButton: SystemButton = {
        let button = SystemButton(title: "Log In", titleColor: .white) { [weak self] in
            self?.logInButtonPressed()
        }
        let bluePixelImage = UIImage(named: "blue_pixel")
        button.setBackgroundImage(bluePixelImage, for: .normal)
        let bluePixelImageWithAlpha80 = bluePixelImage?.withAlpha(0.8)
        button.setBackgroundImage(bluePixelImageWithAlpha80, for: .selected)
        button.setBackgroundImage(bluePixelImageWithAlpha80, for: .highlighted)
        button.setBackgroundImage(bluePixelImageWithAlpha80, for: .disabled)
        button.layer.masksToBounds = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var guessPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Подобрать пароль", for: .normal)
        button.addTarget(self, action: #selector(guessPasswordButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let guessPasswordActivityIndicator = UIActivityIndicatorView(style: .medium)
    
    private lazy var guessPasswordStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [guessPasswordButton, guessPasswordActivityIndicator])
        stack.axis = .horizontal
        stack.spacing = Constants.defaultOffset
        stack.alignment = .center
        return stack
    }()

    private let userService: UserService = {
#if DEBUG
        return TestUserService()
#else
        return CurrentUserService()
#endif
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIControl.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIControl.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIControl.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        [UIControl.keyboardWillShowNotification, UIControl.keyboardDidShowNotification, UIControl.keyboardWillHideNotification].forEach { name in
            NotificationCenter.default.removeObserver(self, name: name, object: nil)
        }
    }
    
    // MARK: - Setup view and constraints
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(scrollViewContentView)
        [logoImageView, textFieldsView, logInButton, guessPasswordStackView].forEach { view in
            scrollViewContentView.addSubview(view)
        }
        [loginTextField, passwordTextField, textFieldsViewSeparator].forEach { view in
            textFieldsView.addSubview(view)
        }
    }
    
    private func setupConstraints() {
        [mainScrollView, scrollViewContentView, logoImageView, textFieldsView, logInButton, loginTextField, passwordTextField, textFieldsViewSeparator, guessPasswordStackView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        let constraints = [mainScrollView.topAnchor.constraint(equalTo: view.topAnchor),
                           mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                           mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                           mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                           
                           scrollViewContentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
                           scrollViewContentView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
                           scrollViewContentView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
                           scrollViewContentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
                           
                           scrollViewContentView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor),
                           
                           logoImageView.topAnchor.constraint(equalTo: scrollViewContentView.safeAreaLayoutGuide.topAnchor, constant: Constants.logoOffset),
                           logoImageView.centerXAnchor.constraint(equalTo: scrollViewContentView.centerXAnchor),
                           logoImageView.heightAnchor.constraint(equalToConstant: Constants.logoSize ),
                           logoImageView.widthAnchor.constraint(equalToConstant: Constants.logoSize),
                           
                           textFieldsView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Constants.logoOffset),
                           textFieldsView.leadingAnchor.constraint(equalTo: scrollViewContentView.safeAreaLayoutGuide.leadingAnchor, constant: Constants.defaultOffset),
                           textFieldsView.trailingAnchor.constraint(equalTo: scrollViewContentView.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.defaultOffset),
                           textFieldsView.heightAnchor.constraint(equalToConstant: Constants.textFieldsViewHeight),
                           
                           loginTextField.topAnchor.constraint(equalTo: textFieldsView.topAnchor),
                           loginTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor, constant: Constants.defaultOffset),
                           loginTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor, constant: -Constants.defaultOffset),
                           loginTextField.bottomAnchor.constraint(equalTo: textFieldsView.centerYAnchor),
                           
                           passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
                           passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
                           passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
                           passwordTextField.bottomAnchor.constraint(equalTo: textFieldsView.bottomAnchor),
                           
                           textFieldsViewSeparator.heightAnchor.constraint(equalToConstant: textFieldsViewBorderWidth),
                           textFieldsViewSeparator.centerYAnchor.constraint(equalTo: textFieldsView.centerYAnchor),
                           textFieldsViewSeparator.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor),
                           textFieldsViewSeparator.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor),
                           
                           logInButton.topAnchor.constraint(equalTo: textFieldsView.bottomAnchor, constant: Constants.defaultOffset),
                           logInButton.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor),
                           logInButton.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor),
                           logInButton.heightAnchor.constraint(equalToConstant: Constants.logInButtonHeight),
                           
                           guessPasswordStackView.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: Constants.defaultOffset),
                           guessPasswordStackView.centerXAnchor.constraint(equalTo: scrollViewContentView.centerXAnchor),
                           guessPasswordStackView.bottomAnchor.constraint(lessThanOrEqualTo: scrollViewContentView.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.defaultOffset)]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Keyboard
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        mainScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        mainScrollView.scrollIndicatorInsets = mainScrollView.contentInset
    }
    
    @objc func keyboardDidShow() {
        mainScrollView.scrollToBottom()
    }
    
    @objc func keyboardWillHide() {
        mainScrollView.contentInset = .zero
        mainScrollView.verticalScrollIndicatorInsets = .zero
    }
    
    // MARK: - Actions
    
    @objc func logInButtonPressed() {
        presenter.logInButtonPressed(login: loginTextField.text, password: passwordTextField.text)
    }
    
    @objc func guessPasswordButtonPressed() {
        DispatchQueue.global(qos: .userInitiated).async {
            let gena = RandomStringGenerator()
            let randomPassword = gena.generate() ?? "K2s"
            DispatchQueue.main.async { [weak self] in
                self?.guessPasswordActivityIndicator.startAnimating()
            }
            let bf = BruteForcier() { $0 == randomPassword }
            // Задание 1 - вызов throw - метода и обработка ошибок
            do {
                try bf.bruteForce(complition: { password in
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.passwordTextField.text = password
                        self.passwordTextField.isSecureTextEntry = false
                    }
                })
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.present(UIAlertController.infoAlert(title: error.localizedDescription, message: "Пароль был: \(randomPassword)"), animated: true)
                }
            }
            DispatchQueue.main.async { [weak self] in
                self?.guessPasswordActivityIndicator.stopAnimating()
            }
        }
    }
}

extension LogInViewController {
    private struct Constants {
        static let logoOffset: CGFloat = 120
        static let logoSize: CGFloat = 100
        static let defaultOffset: CGFloat = 16
        static let textFieldsViewHeight: CGFloat = 100
        static let logInButtonHeight: CGFloat = 50
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            logInButtonPressed()
        }
        return true
    }
}

extension LogInViewController: LoginViewInput {
    func showLogInError(title: String, message: String?) {
        present(UIAlertController.infoAlert(title: title, message: message), animated: true)
    }
}
