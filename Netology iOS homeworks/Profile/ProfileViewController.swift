//
//  ProfileViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр on 22.08.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addProfileView()
        navigationItem.title = "ProfileViewController"
    }

    func addProfileView() {
        let profileView = ProfileView(frame: view.bounds)
        view.addSubview(profileView)
        profileView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
