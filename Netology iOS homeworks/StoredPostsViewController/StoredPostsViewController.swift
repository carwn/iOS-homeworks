//
//  StoredPostsViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 15.06.2022.
//

import UIKit
import CoreData

class StoredPostsViewController: UITableViewController {
    
    var fetchedResultsController: NSFetchedResultsController<StoredPost>? {
        didSet {
            fetchedResultsController?.delegate = self
        }
    }
    var deleteObjectClosure: ((StoredPost) -> Void)?
    
    private let postTableViewCellIdentifier = String(describing: PostTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: postTableViewCellIdentifier)
        navigationItem.title = "Stored posts"
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
        updateDeleteButtonIsActiveStatus()
    }
    
    private func updateDeleteButtonIsActiveStatus() {
        navigationItem.rightBarButtonItem?.isEnabled = !(fetchedResultsController?.fetchedObjects?.isEmpty ?? true)
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        fetchedResultsController?.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: postTableViewCellIdentifier, for: indexPath) as! PostTableViewCell
        cell.post = fetchedResultsController?.object(at: indexPath).post
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions: [.init(style: .destructive, title: "Удалить", handler: { [weak self] _, _, _ in
            guard
                let self = self,
                let post = self.fetchedResultsController?.object(at: indexPath)
            else {
                return
            }
            self.deleteObjectClosure?(post)
        })])
    }
}
