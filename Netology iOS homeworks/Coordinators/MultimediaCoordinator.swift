//
//  MultimediaCoordinator.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 23.02.2022.
//

import UIKit

class MultimediaCoordinator {
    
    private let multimediaViewController: MultimediaViewController
    
    init(audioURLs: [URL], youtubeVideos: [MultimediaStore.YoutubeVideoDescription]) {
        let audioPlayer = DefaultAudioPlayer(audioURLs: audioURLs)
        let audioRecorder = DefaultAudioRecorder()
        let multimediaViewController = MultimediaViewController(audioPlayer: audioPlayer, audioRecorder: audioRecorder, youtubeVideos: youtubeVideos)
        multimediaViewController.tabBarItem = UITabBarItem(title: "multimediaTabTitle".localized,
                                                           image: UIImage(systemName: "music.note.tv"),
                                                           selectedImage: UIImage(systemName: "music.note.tv.fill"))
        audioPlayer.delegate = multimediaViewController
        audioRecorder.delegate = multimediaViewController
        self.multimediaViewController = multimediaViewController
    }
}

extension MultimediaCoordinator: TabBarCoordinator {
    var rootViewController: UIViewController {
        multimediaViewController
    }
    
    func start() {
        
    }
}
