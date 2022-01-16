//
//  PhotosViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 17.09.2021.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var incomingPhotos: [UIImage] = []
    
    // MARK: - Private Properties
    
    private let photosCollectionViewCellIdentifier = String(describing: PhotosCollectionViewCell.self)
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: photosCollectionViewCellIdentifier)
        return collectionView
    }()

    private var collectionViewImages: [UIImage] = []
    private let imagePublisher = ImagePublisherFacade()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Photo Gallery"
        setupView()
        setupConstraints()
        imagePublisher.addImagesWithTimer(time: 0.6, repeat: 21, userImages: incomingPhotos)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        // хорошо бы здесь иметь возможность получить текущий массив изображений из ImagePublisherFacade
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imagePublisher.subscribe(self)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        imagePublisher.removeSubscription(for: self)
    }

    // проверка, что PhotosViewController не участвует в цикличной ссылки памяти и удаляется
#if DEBUG
    deinit {
        print(#function)
    }
#endif
    
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
        collectionViewImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photosCollectionViewCellIdentifier, for: indexPath) as! PhotosCollectionViewCell
        cell.configure(image: collectionViewImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photosInRowCount = Constants.photosInRowCount
        let photosOffsetsCount = photosInRowCount > 0 ? photosInRowCount - 1 : 0
        let totalOffset = Constants.defaultOffset * CGFloat(2 + photosOffsetsCount)
        let size = (collectionView.bounds.width - totalOffset) / CGFloat(photosInRowCount)
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constants.defaultOffset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Constants.defaultOffset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: Constants.defaultOffset, left: Constants.defaultOffset, bottom: Constants.defaultOffset, right: Constants.defaultOffset)
    }
}

extension PhotosViewController {
    private struct Constants {
        static let defaultOffset: CGFloat = 8
        static let photosInRowCount = 3
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        collectionViewImages = images
        collectionView.reloadData()
    }
}
