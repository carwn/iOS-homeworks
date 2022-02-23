//
//  DefaultMultimediaPresenter.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 23.02.2022.
//

import AVFAudio

class DefaultAudioPlayer {
    
    weak var delegate: AudioPlayerDelegate?
    
    private let audioURLs: [URL]
    private var audioPlayer: AVAudioPlayer?
    private var currentAudioIndex: Int?
    
    private var audioListIsEmpty: Bool { audioURLs.isEmpty }
    
    init(audioURLs: [URL]) {
        self.audioURLs = audioURLs
        preparePlayer()
    }
    
    private func preparePlayer() {
        guard !audioListIsEmpty else {
            return
        }
        if currentAudioIndex == nil {
            currentAudioIndex = 0
        }
        guard let currentAudioIndex = currentAudioIndex else {
            return
        }
        guard let newAudioPlayer = try? AVAudioPlayer(contentsOf: audioURLs[currentAudioIndex]) else {
            return
        }
        newAudioPlayer.prepareToPlay()
        audioPlayer = newAudioPlayer
    }
}

extension DefaultAudioPlayer: AudioPlayer {
    var currentAudioName: String {
        guard
            !audioListIsEmpty,
            let currentAudioIndex = currentAudioIndex
        else {
            return "Нет аудио"
        }
        return audioURLs[currentAudioIndex].lastPathComponent
    }
    
    var currentAudioIsPlaying: Bool {
        guard let audioPlayer = audioPlayer else {
            return false
        }
        return audioPlayer.isPlaying
    }
    
    var currentAudioIsInStartPosition: Bool {
        guard let audioPlayer = audioPlayer else {
            return true
        }
        return audioPlayer.currentTime == 0
    }
    
    func play() {
        if audioPlayer == nil {
            preparePlayer()
        }
        audioPlayer?.play()
        delegate?.audioPlayerStatusDidChange()
    }
    
    func pause() {
        guard let audioPlayer = audioPlayer else {
            play()
            return
        }
        if audioPlayer.isPlaying {
            audioPlayer.stop()
        } else {
            audioPlayer.play()
        }
        delegate?.audioPlayerStatusDidChange()
    }
    
    func stop() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        delegate?.audioPlayerStatusDidChange()
    }
}
