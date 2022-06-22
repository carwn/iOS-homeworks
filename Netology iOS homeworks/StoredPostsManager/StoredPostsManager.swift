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
    
    private init() {
        NotificationCenter.default.addObserver(forName: .NSManagedObjectContextDidSave, object: backgroundContex, queue: nil) { [weak self] notification in
            guard let self = self else {
                return
            }
            self.viewContext.perform {
                self.viewContext.mergeChanges(fromContextDidSave: notification)
            }
        }
    }
    
    private let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        return container
    }()
    
    private lazy var viewContext = container.viewContext
    private lazy var backgroundContex = container.newBackgroundContext()
    
    func addPost(_ post: Post, completion: @escaping (Result<Never, Error>) -> Void) {
        addPosts([post], completion: completion)
    }
    
    func addPosts(_ posts: [Post], completion: @escaping (Result<Never, Error>) -> Void) {
        backgroundContex.perform { [weak backgroundContex] in
            guard let backgroundContex = backgroundContex else {
                return
            }
            posts.forEach { let _ = StoredPost(post: $0, context: backgroundContex) }
            do {
                try backgroundContex.save()
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func posts() throws -> [Post] {
        try posts().compactMap { $0.post }
    }
    
    func postsFetchedResultsController() -> NSFetchedResultsController<StoredPost> {
        let fetchRequest = StoredPost.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(StoredPost.saveDate), ascending: true)]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    func removeAllPosts() throws {
        try posts().forEach { viewContext.delete($0) }
        try viewContext.save()
    }
    
    private func posts() throws -> [StoredPost] {
        try viewContext.fetch(StoredPost.fetchRequest())
    }
}


