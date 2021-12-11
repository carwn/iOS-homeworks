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

    private let userService: UserService
    private let userName: String
    
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
    
    private lazy var closeAvatarButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(hideAvatarView), for: .touchUpInside)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.layer.opacity = 0
        return button
    }()

    // MARK: - Initializers

    required init?(coder: NSCoder) {
        fatalError()
    }

    init(userService: UserService, userName: String) {
        self.userService = userService
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
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
        view.addSubviews(tableView, closeAvatarButton)
    }
    
    private func setupConstraints() {
        [tableView, closeAvatarButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        let constraints = tableView.constraints(equalTo: view) + [closeAvatarButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
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
                backgroundView.layer.opacity = 0.7
            }
            UIView.addKeyframe(withRelativeStartTime: 5/8, relativeDuration: 3/8) {
                self.closeAvatarButton.layer.opacity = 1
            }
        }
        self.avatarView = avatarView
        self.avatarBackgroundView = backgroundView
        tableView.isScrollEnabled = false
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
        tableView.isScrollEnabled = true
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
        let user = userService.user(name: userName) ?? User(fullName: "Unknow user", avatarName: nil, status: nil)
        headerView.configure(image: user.avatar, title: user.fullName, currentStatus: user.status)
        headerView.avatarViewTappedClosure = { [weak self] views in
            self?.showAvatarView(avatarView: views.avatarView, backgroundView: views.backgroundView)
        }
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
