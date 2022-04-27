//
//  NetworkService.swift
//  Netology iOS homeworks
//
//  Created by Александр Шелихов on 23.04.2022.
//

import Foundation

class NetworkService {
    func printServerResponce(fromURL url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            self?.printResponse(data: data, response: response, error: error)
        }
        task.resume()
    }
    
    private func printResponse(data: Data?, response: URLResponse?, error: Error?) {
        if let httpResponce = response as? HTTPURLResponse {
            print("StatusCode:", httpResponce.statusCode)
            print("AllHeaderFields:", httpResponce.allHeaderFields)
        } else {
            print("URLResponse is not HTTPURLResponse")
        }
        printDataAsString(data)
        if let error = error {
            print("Error:", error.localizedDescription)
        }
    }
    
    private func printDataAsString(_ data: Data?) {
        guard let data = data else {
            print("Data is nil")
            return
        }
        guard let stringData = String(data: data, encoding: .utf8) else {
            print("Can't create utf8 string from data")
            return
        }
        print("Data:", stringData)
    }
}
