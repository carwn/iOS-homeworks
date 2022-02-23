//
//  AudioRecorder.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 23.02.2022.
//

import Foundation

enum AudioRecorderStatus: CustomStringConvertible {
    case microphoneAccessUnknow
    case microphoneAccessDenied
    case ready
    case recording
    case hasRecord
    case playing
    
    var description: String {
        switch self {
        case .microphoneAccessUnknow:
            return "Требуется доступ к микрофону"
        case .microphoneAccessDenied:
            return "В доступе к микрофону отказано"
        case .ready:
            return "Готов к записи"
        case .recording:
            return "Идет запись..."
        case .hasRecord:
            return "Есть запись"
        case .playing:
            return "Воспроизведение..."
        }
    }
    
    var needRecordButton: Bool {
        switch self {
        case .microphoneAccessUnknow, .microphoneAccessDenied, .ready, .hasRecord:
            return true
        case .recording, .playing:
            return false
        }
    }
    
    var needPlayButton: Bool {
        switch self {
        case .hasRecord:
            return true
        case .microphoneAccessUnknow, .microphoneAccessDenied, .ready, .recording, .playing:
            return false
        }
    }
    
    var needStopButton: Bool {
        switch self {
        case .recording, .playing:
            return true
        case .microphoneAccessUnknow, .microphoneAccessDenied, .ready, .hasRecord:
            return false
        }
    }
}

protocol AudioRecorder: AnyObject {
    var status: AudioRecorderStatus { get }
    
    func record()
    func play()
    func stop()
}
