//
//  PostFetchedResultsController.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 30.06.2022.
//

import Foundation
import CoreData

class PostFetchedResultsController: NSFetchedResultsController<StoredPost> {
    func setAuthorFilter(_ newFilter: String?) {
        let predicate: NSPredicate? = {
            if let newFilter = newFilter {
                return NSPredicate(format: "%K == %@", #keyPath(StoredPost.author), newFilter)
            } else {
                return nil
            }
        }()
        self.fetchRequest.predicate = predicate
    }
}
