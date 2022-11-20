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
        collectionView.backgroundColor = .myBackgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: photosCollectionViewCellIdentifier)
        return collectionView
    }()
    
    private let spinner = UIActivityIndicatorView(style: .large)

    private var collectionViewImages: [UIImage] = []
    private let imagePublisher = ImagePublisherFacade()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "photoGallery".localized
        navigationItem.titleView?.tintColor = .myTextColor
        setupView()
        setupConstraints()
        startPhotosProcessing()
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
        view.addSubviews(collectionView, spinner)
    }
    
    private func setupConstraints() {
        [collectionView, spinner].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        let constraints: [NSLayoutConstraint] = [collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                                                 collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                                 collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                                 collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                                 spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                                 spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func startPhotosProcessing() {
        guard let filter = ColorFilter.allCases.randomElement() else {
            return
        }
        spinner.startAnimating()
        ImageProcessor().processImagesOnThread(sourceImages: incomingPhotos, filter: filter, qos: .userInteractive) { [weak self] images in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                self.spinner.stopAnimating()
                self.imagePublisher.addImagesWithTimer(time: 0.6, repeat: 21, userImages: images.compactMap { $0 }.map { UIImage(cgImage: $0) } )
            }
        }
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
