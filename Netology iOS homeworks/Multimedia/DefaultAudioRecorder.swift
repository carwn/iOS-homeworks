//
//  DefaultAudioRecorder.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 23.02.2022.
//

import AVFAudio

class DefaultAudioRecorder: AudioRecorder {
    
    weak var delegate: AudioRecorderDelegate?
    
    private(set) var status: AudioRecorderStatus {
        didSet {
            delegate?.audioRecorderStatusDidChange()
        }
    }
    
    init() {
        status = .ready
    }
    
    func record() {
        status = .recording
    }
    
    func play() {
        status = .playing
    }
    
    func stop() {
        status = .hasRecord
    }
}

