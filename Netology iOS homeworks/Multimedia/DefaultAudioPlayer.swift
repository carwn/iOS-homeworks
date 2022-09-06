//
//  DefaultMultimediaPresenter.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 23.02.2022.
//

import AVFAudio

class DefaultAudioPlayer: NSObject {
    
    weak var delegate: AudioPlayerDelegate?
    
    private let audioURLs: [URL]
    private var audioPlayer: AVAudioPlayer?
    private var currentAudioIndex: Int?
    
    private var audioListIsEmpty: Bool { audioURLs.isEmpty }
    
    init(audioURLs: [URL]) {
        self.audioURLs = audioURLs
        super.init()
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
        invalidatePlayer()
        guard let newAudioPlayer = try? AVAudioPlayer(contentsOf: audioURLs[currentAudioIndex]) else {
            return
        }
        newAudioPlayer.delegate = self
        newAudioPlayer.prepareToPlay()
        audioPlayer = newAudioPlayer
    }
    
    private func invalidatePlayer() {
        guard let audioPlayer = audioPlayer else {
            return
        }
        audioPlayer.stop()
        self.audioPlayer = nil
    }
}

extension DefaultAudioPlayer: AudioPlayer {
    var currentAudioName: String {
        guard
            !audioListIsEmpty,
            let currentAudioIndex = currentAudioIndex
        else {
            return "noAudio".localized
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
    
    var hasNextFile: Bool {
        guard let currentAudioIndex = currentAudioIndex else {
            return false
        }
        return audioURLs.indices.contains(currentAudioIndex + 1)
    }
    
    var hasPreviousFile: Bool {
        guard let currentAudioIndex = currentAudioIndex else {
            return false
        }
        return audioURLs.indices.contains(currentAudioIndex - 1)
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
    
    func nextFile() {
        guard hasNextFile else {
            return
        }
        guard let currentAudioIndex = currentAudioIndex else {
            return
        }
        self.currentAudioIndex = currentAudioIndex + 1
        if currentAudioIsPlaying {
            invalidatePlayer()
            play()
        } else {
            preparePlayer()
            delegate?.audioPlayerStatusDidChange()
        }
    }
    
    func previousFile() {
        guard hasPreviousFile else {
            return
        }
        guard let currentAudioIndex = currentAudioIndex else {
            return
        }
        self.currentAudioIndex = currentAudioIndex - 1
        if currentAudioIsPlaying {
            invalidatePlayer()
            play()
        } else {
            preparePlayer()
            delegate?.audioPlayerStatusDidChange()
        }
    }
    
    func reopenFile() {
        preparePlayer()
    }
}

extension DefaultAudioPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        delegate?.audioPlayerStatusDidChange()
    }
}
