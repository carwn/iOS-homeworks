//
//  MultimediaStore.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 23.02.2022.
//

import Foundation

class MultimediaStore {
    var audioURLs: [URL] {
        var result = [URL]()
        for fileName in audioFilesNames {
            if let path = Bundle.main.path(forResource: fileName, ofType: "mp3") {
                result.append(URL(fileURLWithPath: path))
            }
        }
        return result
    }
    
    private var audioFilesNames: [String] = ["Queen", "file_example_MP3_700KB", "sample-6s", "sample-9s", "sample-12s", "sample-15s"]
}
