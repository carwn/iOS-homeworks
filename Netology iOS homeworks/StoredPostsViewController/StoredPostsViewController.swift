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
    var deleteButtonPressedClosure: (() -> Void)?
    
    private let postTableViewCellIdentifier = String(describing: PostTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: postTableViewCellIdentifier)
        navigationItem.title = "Stored posts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteButtonPressed))
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
        updateDeleteButtonIsActiveStatus()
    }
    
    func updateDeleteButtonIsActiveStatus() {
        navigationItem.rightBarButtonItem?.isEnabled = !(fetchedResultsController?.fetchedObjects?.isEmpty ?? true)
    }
    
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
    
    @objc
    func deleteButtonPressed() {
        deleteButtonPressedClosure?()
    }
}
