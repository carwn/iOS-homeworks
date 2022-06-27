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
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "clear"),
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(clearFilterButtonPressed)),
                                              UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(setFilterButtonPressed))]
        performFetch(reloadTableView: false)
    }
    
    @objc
    private func setFilterButtonPressed() {
        let alert = UIAlertController(title: "Фильтр по автору", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Применить", style: .default, handler: { [weak self] _ in
            let authorFilter = alert.textFields![0].text
            self?.setAuthorFilter(authorFilter)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc
    private func clearFilterButtonPressed() {
        setAuthorFilter(nil)
    }
    
    private func setAuthorFilter(_ newFilter: String?) {
        // понимаю, что формированию предиката не место во ViewController, но уже нет сил делать по уму :(
        let predicate: NSPredicate? = {
            if let newFilter = newFilter {
                return NSPredicate(format: "%K == %@", #keyPath(StoredPost.author), newFilter)
            } else {
                return nil
            }
        }()
        fetchedResultsController?.fetchRequest.predicate = predicate
        performFetch(reloadTableView: true)
        if #available(iOS 15.0, *) {
            navigationItem.rightBarButtonItems![1].isSelected = newFilter != nil
        }
    }
    
    private func performFetch(reloadTableView: Bool) {
        do {
            try fetchedResultsController?.performFetch()
            if reloadTableView {
                tableView.reloadData()
            }
        } catch {
            showError(error)
        }
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
