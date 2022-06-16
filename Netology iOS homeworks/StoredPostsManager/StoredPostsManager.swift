//
//  StoredPostsManager.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 15.06.2022.
//

import Foundation
import CoreData
import StorageService

class StoredPostsManager {
    
    static let shared = StoredPostsManager()
    
    private init() {}
    
    private let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    private lazy var context = container.viewContext
    
    func addPost(_ post: Post) throws {
        try addPosts([post])
    }
    
    func addPosts(_ posts: [Post]) throws {
        posts.forEach { let _ = StoredPost(post: $0, context: context) }
        try context.save()
    }
    
    func posts() throws -> [Post] {
        try posts().compactMap { $0.post }
    }
    
    func postsFetchedResultsController() -> NSFetchedResultsController<StoredPost> {
        let fetchRequest = StoredPost.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(StoredPost.saveDate), ascending: true)]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    func removeAllPosts() throws {
        try posts().forEach { context.delete($0) }
        try context.save()
    }
    
    private func posts() throws -> [StoredPost] {
        try context.fetch(StoredPost.fetchRequest())
    }
}


