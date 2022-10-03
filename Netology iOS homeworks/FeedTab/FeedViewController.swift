//
//  FeedViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 27.08.2021.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {

    // MARK: - Public Properties
    var onPushPostViewControllerButtonPressed: ((PostViewController.Post) -> Void)?
    
    // MARK: - Private Properties
    private lazy var inputTextView: InputTextView = {
        let inputTextView = InputTextView()
        inputTextView.delegate = self
        return inputTextView
    }()

    private lazy var buttonsStackView: UIStackView = {
        func pushPostViewControllerButton(number: Int) -> SystemButton {
            let button = SystemButton(title: "\("pushPostViewController".localized) \("numberSing".localized)\(number)")
            button.onTapHandler = { [weak self] in
                self?.pushPostViewControllerButtonPressed()
            }
            return button
        }
        let stack = UIStackView(arrangedSubviews: [pushPostViewControllerButton(number: 1),
                                                   pushPostViewControllerButton(number: 2)])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    private lazy var inputTextStackView: UIStackView = {
        let inputTextStackView = UIStackView(arrangedSubviews: [inputTextView, spinner, resultLabel])
        inputTextStackView.axis = .vertical
        inputTextStackView.spacing = 10
        return inputTextStackView
    }()

    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()

    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let randomColorSquare: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.randomColorSquareCornerRadius
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = Constants.randomColorSquareBorderWidth
        return view
    }()
    
    private lazy var timerUIStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timerLabel, randomColorSquare])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = Constants.randomColorSquareHorizontalSpacing
        return stack
    }()

    private let wordChecker: WordChecker
    private weak var coordinator: FeedCoordinator?
    private var secondsToChangeColor = 5
    private var everySecondTimer: Timer?

    // MARK: - Initializers
    init(wordChecker: WordChecker, coordinator: FeedCoordinator) {
        self.wordChecker = wordChecker
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "FeedViewController".localized
        view.backgroundColor = UIColor(named: "BackgroundColor")
        updateTimerLabelText()
        setRandomColorForSquareView()
        setupViewsAndConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        destroyTimer()
    }
    
    deinit {
        destroyTimer()
    }

    // MARK: - Private Methods
    private func setupViewsAndConstraints() {
        let container = UIView()
        container.addSubview(buttonsStackView)
        container.addSubview(inputTextStackView)
        view.addSubview(container)
        container.center(in: view)

        view.addSubview(timerUIStackView)
        timerUIStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(container.snp_topMargin).offset(-60)
        }
        
        randomColorSquare.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: Constants.randomColorSquareFace, height: Constants.randomColorSquareFace))
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        inputTextStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(buttonsStackView.snp_bottomMargin).offset(25)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(view).multipliedBy(0.85)
        }
    }

    private func updateResultLabelText(_ result: WordChecker.Result) {
        let color: UIColor = {
            switch result {
            case .correct:
                return .green
            case .notCorrect, .checkError:
                return .red
            }
        }()
        self.resultLabel.textColor = color
        self.resultLabel.text = result.description
    }

    @objc
    private func pushPostViewControllerButtonPressed() {
        let post = PostViewController.Post(title: "Hello".localized)
        onPushPostViewControllerButtonPressed?(post)
    }
    
    private func updateTimerLabelText() {
        timerLabel.text = "\("timerLabelText".localized): \(secondsToChangeColor)"
    }
    
    private func setRandomColorForSquareView() {
        randomColorSquare.backgroundColor = .random
    }
    
    private func createTimer() {
        let timer = Timer(timeInterval: 1, repeats: true) { [weak self] _ in
            self?.everySecondTimerFire()
        }
        RunLoop.main.add(timer, forMode: .common)
        everySecondTimer = timer
    }
    
    private func destroyTimer() {
        guard let everySecondTimer = everySecondTimer else {
            return
        }
        everySecondTimer.invalidate()
        self.everySecondTimer = nil
    }
    
    private func everySecondTimerFire() {
        secondsToChangeColor -= 1
        if secondsToChangeColor == 0 {
            setRandomColorForSquareView()
            secondsToChangeColor = 5
        }
        updateTimerLabelText()
    }
}

extension FeedViewController: InputTextViewDelegate {
    func userInputedText(text: String?) {
        guard let text = text, !text.isEmpty else {
            present(UIAlertController.infoAlert(title: "noInputText".localized), animated: true)
            return
        }
        spinner.startAnimating()
        resultLabel.isHidden = true
        wordChecker.check(word: text) { [weak self] result in
            guard let self = self else {
                return
            }
            self.spinner.stopAnimating()
            self.updateResultLabelText(result)
            self.resultLabel.isHidden = false
        }
    }
}

extension FeedViewController {
    enum Constants {
        static let randomColorSquareFace: CGFloat = 40
        static let randomColorSquareCornerRadius: CGFloat = randomColorSquareFace / 5
        static let randomColorSquareBorderWidth: CGFloat = randomColorSquareFace / 15
        static let randomColorSquareHorizontalSpacing: CGFloat = randomColorSquareFace / 2.5
    }
}
