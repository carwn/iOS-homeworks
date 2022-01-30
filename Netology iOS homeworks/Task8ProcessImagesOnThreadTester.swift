//
//  Task8ProcessImagesOnThreadTester.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 30.01.2022.
//

import UIKit
import iOSIntPackage
import StorageService

class Task8ProcessImagesOnThreadTester {
    let qoss: [QualityOfService] = [.background, .utility, .default, .userInitiated, .userInteractive]
    let filters: [ColorFilter] = ColorFilter.allCases
    let postImages: [UIImage] = Post.postsExample.compactMap { UIImage(named: $0.image) }
    let photos: [UIImage] = PhotosStore.testPhotoNames.compactMap { UIImage(named: $0) }
    
    func start(specificImages: [UIImage]? = nil,
               specificQos: QualityOfService? = nil,
               specificFilter: ColorFilter? = nil) {
        DispatchQueue.main.async {
            print("Start test")
        }
        let imageProcessor = ImageProcessor()
        for images in specificImages != nil ? [specificImages!] : [postImages, photos] {
            for filter in specificFilter != nil ? [specificFilter!] : filters {
                for qos in specificQos != nil ? [specificQos!] : qoss {
                    DispatchQueue.global().async {
                        let startTime = CFAbsoluteTimeGetCurrent()
                        imageProcessor.processImagesOnThread(sourceImages: images, filter: filter, qos: qos) { processedImages in
                            let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
                            DispatchQueue.main.async {
                                print("\(String(format: "%.3f", timeElapsed)) seconds for processing \(images.count) images with \(filter) in \(qos) qos")
                            }
                        }
                    }
                }
            }
        }
    }
}

extension QualityOfService: CustomStringConvertible {
    public var description: String {
        switch self {
        case .userInteractive:
            return "userInteractive"
        case .userInitiated:
            return "userInitiated"
        case .utility:
            return "utility"
        case .background:
            return "background"
        case .default:
            return "default"
        default:
            return "unknow"
        }
    }
}
