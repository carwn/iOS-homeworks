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
    
    private lazy var closeAvatarButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(hideAvatarView), for: .touchUpInside)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.layer.opacity = 0
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.addSubviews(tableView, closeAvatarButton)
    }
    
    private func setupConstraints() {
        [tableView, closeAvatarButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        let constraints = tableView.constraints(equalTo: view) + [closeAvatarButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                                                                  closeAvatarButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func showAvatarView(avatarView: UIView, backgroundView: UIView) {
        backgroundView.frame = view.bounds
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 5/8) {
                let cornerRadiusAnimation = self.cornerRadiusAnimation(fromValue: avatarView.layer.cornerRadius,
                                                                       toValue: 0,
                                                                       duration: 0.5)
                avatarView.layer.add(cornerRadiusAnimation, forKey: "cornerRadiusAnimation")
                let scale: CGFloat = self.view.bounds.width / avatarView.bounds.width
                avatarView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.midX - avatarView.center.x, y: UIScreen.main.bounds.midY - avatarView.center.y).scaledBy(x: scale, y: scale)
                backgroundView.layer.opacity = 0.6
            }
            UIView.addKeyframe(withRelativeStartTime: 5/8, relativeDuration: 3/8) {
                self.closeAvatarButton.layer.opacity = 1
            }
        }
        self.avatarView = avatarView
        self.avatarBackgroundView = backgroundView
    }
    
    private func cornerRadiusAnimation(fromValue: CGFloat, toValue: CGFloat, duration: TimeInterval) -> CAAnimation {
        let cornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerRadiusAnimation.fromValue = fromValue
        cornerRadiusAnimation.toValue = toValue
        cornerRadiusAnimation.duration = duration
        cornerRadiusAnimation.fillMode = .forwards
        cornerRadiusAnimation.isRemovedOnCompletion = false
        return cornerRadiusAnimation
    }
    
    private weak var avatarView: UIView?
    private weak var avatarBackgroundView: UIView?
    
    @objc private func hideAvatarView() {
        let duration: TimeInterval = 0.5
        UIView.animate(withDuration: duration) {
            if let avatarView = self.avatarView {
                let cornerRadiusAnimation = self.cornerRadiusAnimation(fromValue: 0,
                                                                       toValue: avatarView.bounds.height / 2,
                                                                       duration: duration)
                avatarView.layer.add(cornerRadiusAnimation, forKey: "cornerRadiusAnimation")
            }
            self.avatarView?.transform = .identity
            self.avatarBackgroundView?.layer.opacity = 0
            self.closeAvatarButton.layer.opacity = 0
        }
        self.avatarView = nil
        self.avatarBackgroundView = nil
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
        headerView.avatarViewTappedClosure = { [weak self] views in
            self?.showAvatarView(avatarView: views.avatarView, backgroundView: views.backgroundView)
        }
        return headerView
    }
}
