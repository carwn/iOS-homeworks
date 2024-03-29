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
    
    // MARK: - View context
    
    func posts() throws -> [Post] {
        try posts(context: viewContext).compactMap { $0.post }
    }
    
    func postsFetchedResultsController() -> PostFetchedResultsController {
        let fetchRequest = StoredPost.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(StoredPost.author), ascending: true),
                                        NSSortDescriptor(key: #keyPath(StoredPost.saveDate), ascending: true)]
        return PostFetchedResultsController(fetchRequest: fetchRequest,
                                            managedObjectContext: viewContext,
                                            sectionNameKeyPath: #keyPath(StoredPost.author),
                                            cacheName: nil)
    }
    
    // MARK: - Background context
    
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
                completion(.failure(StoredPostsManagerError.other(error: error)))
            }
        }
    }
    
    func removePost(_ postForRemove: StoredPost, completion: @escaping (Result<Never, Error>) -> Void) {
        backgroundContex.perform { [weak self] in
            guard let self = self else {
                return
            }
            guard let postInBackgroundContext = self.post(id: postForRemove.objectID, context: self.backgroundContex) else {
                completion(.failure(StoredPostsManagerError.cantDelete))
                return
            }
            self.backgroundContex.delete(postInBackgroundContext)
            do {
                try self.backgroundContex.save()
            } catch {
                completion(.failure(StoredPostsManagerError.other(error: error)))
            }
        }
    }
    
    // MARK: - Private methods
    
    private func posts(context: NSManagedObjectContext) throws -> [StoredPost] {
        try context.fetch(StoredPost.fetchRequest())
    }
    
    private func post(id: NSManagedObjectID, context: NSManagedObjectContext) -> StoredPost? {
        context.object(with: id) as? StoredPost
    }
}


