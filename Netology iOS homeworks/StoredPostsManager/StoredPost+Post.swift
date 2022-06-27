//
//  StoredPost+Post.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 15.06.2022.
//

import Foundation
import CoreData
import StorageService

extension StoredPost {
    convenience init(post: Post, context: NSManagedObjectContext) {
        self.init(entity: StoredPost.entity(), insertInto: context)
        author = post.author
        text = post.description
        imageName = post.image
        likesCount = Int64(post.likes)
        views = Int64(post.views)
        saveDate = Self.dateFormatter.string(from: Date())
    }
    
    var post: Post? {
        guard let author = author,
              let description = text,
              let image = imageName
        else {
            return nil
        }
        
        return Post(author: author,
                    description: description,
                    image: image,
                    likes: Int(likesCount),
                    views: Int(views))
    }
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter
    }()
}
