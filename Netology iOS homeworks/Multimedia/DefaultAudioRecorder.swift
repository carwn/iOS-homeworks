//
//  DefaultAudioRecorder.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 23.02.2022.
//

import AVFAudio

class DefaultAudioRecorder: NSObject, AudioRecorder {
    
    weak var delegate: AudioRecorderDelegate?
    
    private(set) var status: AudioRecorderStatus {
        didSet {
            delegate?.audioRecorderStatusDidChange()
        }
    }
    
    var hasRecord: Bool {
        FileManager.default.fileExists(atPath: audioFilename.path)
    }
    
    private let audioFilename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("recording.m4a")
    private let recordingSession = AVAudioSession()
    private var audioRecorder: AVAudioRecorder?
    private lazy var player: DefaultAudioPlayer = {
        let player = DefaultAudioPlayer(audioURLs: [audioFilename])
        player.delegate = self
        return player
    }()
    
    override init() {
        status = .ready
        super.init()
        updateStatus()
    }
    
    func record() {
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission { [weak self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self?.startRecord()
                    } else {
                        self?.updateStatus()
                    }
                }
            }
        } catch {
            delegate?.showError(title: error.localizedDescription, message: nil)
        }
    }
    
    func play() {
        player.play()
    }
    
    func stop() {
        switch status {
        case .recording:
            finishRecording(success: true)
        case .playing:
            player.stop()
        default:
            break
        }
    }
    
    private func startRecord() {
        let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                      AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
             AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            updateStatus()
        } catch {
            finishRecording(success: false)
        }
    }
    
    private func finishRecording(success: Bool) {
        audioRecorder?.stop()
        audioRecorder = nil
        player.reopenFile()
        if success {
            updateStatus()
        } else {
            status = .recordFail
        }
    }
    
    private func updateStatus() {
        if let audioRecorder = audioRecorder, audioRecorder.isRecording {
            status = .recording
        } else if player.currentAudioIsPlaying {
            status = .playing
        } else {
            switch recordingSession.recordPermission {
            case .undetermined:
                status = .microphoneAccessUnknow
            case .denied:
                status = .microphoneAccessDenied
            case .granted:
                status = .ready
            @unknown default:
                status = .microphoneAccessUnknow
            }
        }
    }
}

extension DefaultAudioRecorder: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}

extension DefaultAudioRecorder: AudioPlayerDelegate {
    func audioPlayerStatusDidChange() {
        updateStatus()
    }
}
