//
//  MultimediaStore.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 23.02.2022.
//

import Foundation

class MultimediaStore {
    
    struct YoutubeVideoDescription {
        var title: String
        let videoId: String
    }
    
    var audioURLs: [URL] {
        var result = [URL]()
        for fileName in audioFilesNames {
            if let path = Bundle.main.path(forResource: fileName, ofType: "mp3") {
                result.append(URL(fileURLWithPath: path))
            }
        }
        return result
    }
    
    var youtubeVideos: [YoutubeVideoDescription] {
        [YoutubeVideoDescription(title: "Онлайн-образование. Революция уже наступила? — фильм Катерины Гордеевой", videoId: "xOgT2qYAzds"),
         YoutubeVideoDescription(title: "ОДНА ПРОФЕССИЯ НА ВСЮ ЖИЗНЬ? За и Против. Спорно", videoId: "pucrVT_ddJ0"),
         YoutubeVideoDescription(title: "10 глупых вопросов фотографу — Никита Палшков", videoId: "80z9Zs7vNQA"),
         YoutubeVideoDescription(title: "О ЧЁМ Я ЖАЛЕЮ В КАРЬЕРЕ? Выводы после 10, 15, 35 лет работы — Работе время", videoId: "DjseLmJ6CK4"),
         YoutubeVideoDescription(title: "Как планировать жизнь на фрилансе? Галина Юзефович, Аня Войн, Никита Маклахов", videoId: "2CiwnrykplM")]
    }
    
    private var audioFilesNames: [String] = ["Queen", "file_example_MP3_700KB", "sample-6s", "sample-9s", "sample-12s", "sample-15s"]
}
