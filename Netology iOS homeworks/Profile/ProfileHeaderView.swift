//
//  ProfileHeaderView.swift
//  Netology iOS homeworks
//
//  Created by Александр on 02.09.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let helloLabel = UILabel()
        helloLabel.text = "ProfileHeaderView"
        addSubview(helloLabel)
        helloLabel.center(in: self)
    }
}
