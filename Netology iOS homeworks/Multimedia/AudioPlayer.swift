//
//  AudioPlayer.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 23.02.2022.
//

import Foundation

protocol AudioPlayer: AnyObject {
    var currentAudioName: String { get }
    var currentAudioIsPlaying: Bool { get }
    
    func play()
    func pause()
}
