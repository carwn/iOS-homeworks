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
        view.backgroundColor = UIColor(named: "BackgroundColor")
        addProfileView()
        navigationItem.title = "ProfileViewController"
    }

    func addProfileView() {
        let profileView = ProfileView(frame: view.bounds)
        view.addSubview(profileView)
        profileView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        profileView.configure(name: "John Smith", birthday: "01.01.1990", place: "Cupertino", photo: #imageLiteral(resourceName: "AvatarTemplate"), caption: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.")
    }
}
