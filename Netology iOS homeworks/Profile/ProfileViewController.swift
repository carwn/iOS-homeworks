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
    
    var photos: [UIImage] = PhotosStore.testPhotoNames.compactMap { UIImage(named: $0) } {
        didSet {
            tableView.reloadSections(IndexSet(integer: Section.photos.rawValue), with: .automatic)
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
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
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
    private enum Section: Int, CaseIterable {
        case photos, posts
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .photos: return 1
        case .posts: return posts.count
        case nil: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section) {
        case .photos:
            let cell = tableView.dequeueReusableCell(withIdentifier: photosTableViewCellIdentifier, for: indexPath) as! PhotosTableViewCell
            cell.photos = Array(photos.prefix(through: 3))
            cell.selectionStyle = .default
            return cell
        case .posts:
            let cell = tableView.dequeueReusableCell(withIdentifier: postTableViewCellIdentifier, for: indexPath) as! PostTableViewCell
            cell.post = posts[indexPath.row]
            cell.selectionStyle = .none
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == Section.photos.rawValue {
            let photosVC = PhotosViewController()
            photosVC.photos = photos
            navigationController?.pushViewController(photosVC, animated: true)
        }
    }
}
