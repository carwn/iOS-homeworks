//
//  MultimediaViewController.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 23.02.2022.
//

import UIKit
import AVFoundation
import YouTubeiOSPlayerHelper

class MultimediaViewController: UIViewController {
    
    private let audioPlayer: AudioPlayer
    private let audioRecorder: AudioRecorder
    private let youtubeVideos: [MultimediaStore.YoutubeVideoDescription]
    private var shownVideoId: String?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(TitleButtonsCell.self, forCellReuseIdentifier: String(describing: TitleButtonsCell.self))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.register(YoutubeVideoCell.self, forCellReuseIdentifier: String(describing: YoutubeVideoCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    required init(audioPlayer: AudioPlayer, audioRecorder: AudioRecorder, youtubeVideos: [MultimediaStore.YoutubeVideoDescription]) {
        self.audioPlayer = audioPlayer
        self.audioRecorder = audioRecorder
        self.youtubeVideos = youtubeVideos
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
    
    private enum Sections: Int, CaseIterable {
        case audioPlayer, youtubeVideo, recordAudio
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Sections(rawValue: section) {
        case .audioPlayer, .recordAudio: return 1
        case .youtubeVideo: return shownVideoId == nil ? youtubeVideos.count : youtubeVideos.count + 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Sections.init(rawValue: indexPath.section) {
        case .audioPlayer:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleButtonsCell.self), for: indexPath) as! TitleButtonsCell
            configureAudioPlayerCell(cell)
            return cell
        case .youtubeVideo:
            if let videoId = shownVideoId, indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YoutubeVideoCell.self), for: indexPath) as! YoutubeVideoCell
                cell.videoId = videoId
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
                let youtubeVideo = youtubeVideo(forIndexPath: indexPath)
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = youtubeVideo?.title
                cell.accessoryType = youtubeVideo?.videoId == shownVideoId ? .checkmark : .none
                return cell
            }
        case .recordAudio:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TitleButtonsCell.self), for: indexPath) as! TitleButtonsCell
            configureRecordCell(cell)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    private func youtubeVideo(forIndexPath indexPath: IndexPath) -> MultimediaStore.YoutubeVideoDescription? {
        guard indexPath.section == Sections.youtubeVideo.rawValue else {
            return nil
        }
        let index = shownVideoId == nil ? indexPath.row : indexPath.row - 1
        guard youtubeVideos.indices.contains(index) else {
            return nil
        }
        return youtubeVideos[index]
    }
    
    private func configureAudioPlayerCell(_ cell: TitleButtonsCell) {
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
    }
    
    private func configureRecordCell(_ cell: TitleButtonsCell) {
        cell.configure(audioRecorder: audioRecorder)
        cell.playButtonClosure = { [weak self] in
            self?.audioRecorder.play()
        }
        cell.stopButtonClosure = { [weak self] in
            self?.audioRecorder.stop()
        }
        cell.recordButtonClosure = { [weak self] in
            self?.audioRecorder.record()
        }
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch Sections(rawValue: section) {
        case .audioPlayer: return "Аудио плееер"
        case .youtubeVideo: return "YouTube видео"
        case .recordAudio: return "Запись аудио"
        default: return nil
        }
    }
}

extension MultimediaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Sections(rawValue: indexPath.section) {
        case .youtubeVideo:
            if let newVideoId = youtubeVideo(forIndexPath: indexPath)?.videoId {
                let oldShowVideoId = shownVideoId
                shownVideoId = newVideoId
                if oldShowVideoId == nil {
                    insertYoutubeVideo(selectedIndexPath: indexPath)
                } else if newVideoId == oldShowVideoId {
                    shownVideoId = nil
                    removeYoutubeVideo(selectedIndexPath: indexPath)
                } else {
                    replaceYoutubeVideo(selectedIndexPath: indexPath, oldSelectedIndexPath: IndexPath(row: youtubeVideos.firstIndex(where: { $0.videoId == oldShowVideoId })! + 1, section: Sections.youtubeVideo.rawValue))
                }
            }
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard
            indexPath.section == Sections.youtubeVideo.rawValue,
            shownVideoId != nil,
            indexPath.row == 0
        else {
            return UITableView.automaticDimension
        }
        return (tableView.bounds.width - tableView.layoutMargins.left - tableView.layoutMargins.right) * 9 / 16
    }
    
    private func removeYoutubeVideo(selectedIndexPath: IndexPath) {
        tableView.beginUpdates()
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: Sections.youtubeVideo.rawValue)) as? YoutubeVideoCell {
            cell.videoId = nil
        }
        tableView.deleteRows(at: [IndexPath(row: 0, section: Sections.youtubeVideo.rawValue)], with: .bottom)
        tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        tableView.endUpdates()
    }
    
    private func insertYoutubeVideo(selectedIndexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: Sections.youtubeVideo.rawValue)], with: .bottom)
        tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        tableView.endUpdates()
    }
    
    private func replaceYoutubeVideo(selectedIndexPath: IndexPath, oldSelectedIndexPath: IndexPath) {
        tableView.beginUpdates()
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: Sections.youtubeVideo.rawValue)) as? YoutubeVideoCell {
            cell.videoId = shownVideoId
        }
        tableView.reloadRows(at: [IndexPath(row: 0, section: Sections.youtubeVideo.rawValue), selectedIndexPath, oldSelectedIndexPath], with: .fade)
        tableView.endUpdates()
    }
}

extension MultimediaViewController: AudioPlayerDelegate {
    func audioPlayerStatusDidChange() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: Sections.audioPlayer.rawValue)) as? TitleButtonsCell else {
            return
        }
        cell.configure(audioPlayer: audioPlayer)
    }
}

extension MultimediaViewController: AudioRecorderDelegate {
    func audioRecorderStatusDidChange() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: Sections.recordAudio.rawValue)) as? TitleButtonsCell else {
            return
        }
        cell.configure(audioRecorder: audioRecorder)
    }
}
