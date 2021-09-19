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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: postTableViewCellIdentifier)
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
    
    private func animateAvatarView(avatarView: UIView) {
        UIView.animate(withDuration: 1) {
            avatarView.center = self.view.center
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: postTableViewCellIdentifier, for: indexPath) as! PostTableViewCell
        cell.post = posts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else {
            return nil
        }
        let headerView = ProfileHeaderView()
        headerView.configure(image: UIImage(named: "Cat"), title: "Hipster Cat", currentStatus: nil)
        headerView.avatarViewTappedClosure = { [weak self] avatarView in
            self?.animateAvatarView(avatarView: avatarView)
        }
        return headerView
    }
}
