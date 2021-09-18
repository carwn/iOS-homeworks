//
//  PhotosViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 17.09.2021.
//

import UIKit

class PhotosViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var photos: [UIImage] = []
    
    // MARK: - Private Properties
    
    private let photosCollectionViewCellIdentifier = String(describing: PhotosCollectionViewCell.self)
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: photosCollectionViewCellIdentifier)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Photo Gallery"
        setupView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                                                 collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                                 collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                                 collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photosCollectionViewCellIdentifier, for: indexPath) as! PhotosCollectionViewCell
        cell.configure(image: photos[indexPath.row])
        return cell
    }
}
