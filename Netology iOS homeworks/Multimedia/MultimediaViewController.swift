//
//  MultimediaViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 23.02.2022.
//

import UIKit
import AVFoundation

class MultimediaViewController: UIViewController {
    
    private let audioPlayer: AudioPlayer
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(AudioPlayerCell.self, forCellReuseIdentifier: String(describing: AudioPlayerCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    required init(audioPlayer: AudioPlayer) {
        self.audioPlayer = audioPlayer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(tableView.constraints(equalTo: view))
    }
}

extension MultimediaViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AudioPlayerCell.self), for: indexPath) as! AudioPlayerCell
        cell.configure(audioPlayer: audioPlayer)
        cell.playButtonClosure = { [weak self] in
            self?.audioPlayer.play()
        }
        cell.pauseButtonClosure = { [weak self] in
            self?.audioPlayer.pause()
        }
        cell.stopButtonClosure = { [weak self] in
            self?.audioPlayer.stop()
        }
        cell.nextButtonClosure = { [weak self] in
            self?.audioPlayer.nextFile()
        }
        cell.previousButtonClosure = { [weak self] in
            self?.audioPlayer.previousFile()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Аудио плееер"
    }
}

extension MultimediaViewController: UITableViewDelegate {
    
}

extension MultimediaViewController: AudioPlayerDelegate {
    func audioPlayerStatusDidChange() {
        guard let audioCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AudioPlayerCell else {
            return
        }
        audioCell.configure(audioPlayer: audioPlayer)
    }
}
