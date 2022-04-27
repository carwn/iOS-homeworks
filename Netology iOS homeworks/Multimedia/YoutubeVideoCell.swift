//
//  YoutubeVideoCell.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 23.02.2022.
//

import UIKit
import YouTubeiOSPlayerHelper

class YoutubeVideoCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    var videoId: String? {
        didSet {
            if let videoId = videoId {
                ytPlayerView.load(withVideoId: videoId)
                ytPlayerView.playVideo()
            } else {
                ytPlayerView.stopVideo()
            }
        }
    }
    
    // MARK: - Private Properties
    
    private let ytPlayerView = YTPlayerView(frame: .zero)
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        contentView.addSubviews(ytPlayerView)
        ytPlayerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(ytPlayerView.constraints(equalTo: contentView))
    }
}
