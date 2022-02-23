//
//  AudioPlayerCell.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 23.02.2022.
//

import UIKit

class AudioPlayerCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    var playButtonClosure: (() -> Void)?
    var pauseButtonClosure: (() -> Void)?
    var stopButtonClosure: (() -> Void)?
    
    // MARK: - Private Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var pauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.addTarget(self, action: #selector(pauseButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Public Methods
    func configure(audioPlayer: AudioPlayer) {
        titleLabel.text = audioPlayer.currentAudioName
        playButton.isHidden = audioPlayer.currentAudioIsPlaying
        pauseButton.isHidden = !audioPlayer.currentAudioIsPlaying
        stopButton.isHidden = !audioPlayer.currentAudioIsPlaying && audioPlayer.currentAudioIsInStartPosition
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        let buttonsStack = UIStackView(arrangedSubviews: [playButton, pauseButton, stopButton])
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = Constants.defaultOffset
        buttonsStack.alignment = .center
        contentView.addSubviews(titleLabel, buttonsStack)
        [titleLabel, buttonsStack].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.defaultOffset),
                                     titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.defaultOffset),
                                     titleLabel.trailingAnchor.constraint(equalTo: buttonsStack.leadingAnchor, constant: Constants.defaultOffset),
                                     titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.defaultOffset),
                                     
                                     buttonsStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.defaultOffset),
                                     buttonsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.defaultOffset),
                                     buttonsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.defaultOffset)])
    }
    
    @objc private func playButtonPressed() {
        playButtonClosure?()
    }
    
    @objc private func pauseButtonPressed() {
        pauseButtonClosure?()
    }
    
    @objc private func stopButtonPressed() {
        stopButtonClosure?()
    }
}

extension AudioPlayerCell {
    private struct Constants {
        static let defaultOffset: CGFloat = 16
    }
}
