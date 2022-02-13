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
    
    static let defaultPostImages: [UIImage] = Post.postsExample.compactMap { UIImage(named: $0.image) }
    static let defaultPhotos: [UIImage] = PhotosStore.testPhotoNames.compactMap { UIImage(named: $0) }
    
    var qoss: [QualityOfService]?
    var filters: [ColorFilter]?
    var images: [UIImage]?
    
    private static let defaultQoss: [QualityOfService] = [.background, .utility, .default, .userInitiated, .userInteractive]
    private static let defaultFilters: [ColorFilter] = ColorFilter.allCases
    
    func start() {
        DispatchQueue.main.async {
            print("Start test")
        }
        let imageProcessor = ImageProcessor()
        for images in images != nil ? [images!] : [Self.defaultPostImages, Self.defaultPhotos] {
            for filter in filters != nil ? filters! : Self.defaultFilters {
                for qos in qoss != nil ? qoss! : Self.defaultQoss {
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
