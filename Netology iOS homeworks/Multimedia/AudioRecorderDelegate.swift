//
//  AudioRecorderDelegate.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 23.02.2022.
//

import Foundation

protocol AudioRecorderDelegate: AnyObject {
    func audioRecorderStatusDidChange()
    func showError(title: String, message: String?)
}
