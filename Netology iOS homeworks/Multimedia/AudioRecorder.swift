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
    case playing
    case recordFail
    
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
        case .playing:
            return "Воспроизведение..."
        case .recordFail:
            return "Запись не удалась"
        }
    }
    
    var needRecordButton: Bool {
        switch self {
        case .microphoneAccessUnknow, .ready, .recordFail:
            return true
        case .recording, .playing, .microphoneAccessDenied:
            return false
        }
    }
    
    var needStopButton: Bool {
        switch self {
        case .recording, .playing:
            return true
        case .microphoneAccessUnknow, .microphoneAccessDenied, .ready, .recordFail:
            return false
        }
    }
}

protocol AudioRecorder: AnyObject {
    var status: AudioRecorderStatus { get }
    var hasRecord: Bool { get }
    
    func record()
    func play()
    func stop()
}
