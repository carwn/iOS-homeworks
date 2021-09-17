//
//  ProfileViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр on 22.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var posts: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Private Properties
    
    private let postTableViewCellIdentifier = String(describing: PostTableViewCell.self)
    private let photosTableViewCellIdentifier = String(describing: PhotosTableViewCell.self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: postTableViewCellIdentifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: photosTableViewCellIdentifier)
        tableView.allowsSelection = false
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [tableView.topAnchor.constraint(equalTo: view.topAnchor),
                           tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                           tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                           tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    private enum Section: CaseIterable {
        case photos, posts
        init?(section: Int) {
            switch section {
            case 0: self = .photos
            case 1: self = .posts
            default: return nil
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(section: section) {
        case .photos: return 1
        case .posts: return posts.count
        case nil: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(section: indexPath.section) {
        case .photos:
            let cell = tableView.dequeueReusableCell(withIdentifier: photosTableViewCellIdentifier, for: indexPath) as! PhotosTableViewCell
            cell.photos = Array(PhotosStore.testPhotoNames.prefix(through: 3)).compactMap { UIImage(named: $0) }
            return cell
        case .posts:
            let cell = tableView.dequeueReusableCell(withIdentifier: postTableViewCellIdentifier, for: indexPath) as! PostTableViewCell
            cell.post = posts[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else {
            return nil
        }
        let headerView = ProfileHeaderView()
        headerView.configure(image: UIImage(named: "Cat"), title: "Hipster Cat", currentStatus: nil)
        return headerView
    }
}
