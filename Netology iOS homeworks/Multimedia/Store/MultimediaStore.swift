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
        if let queenPath = Bundle.main.path(forResource: "Queen", ofType: "mp3") {
            result.append(URL(fileURLWithPath: queenPath))
        }
        return result
    }
}
