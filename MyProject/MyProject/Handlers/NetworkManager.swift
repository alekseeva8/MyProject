//
//  NetworkManager.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/7/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static func downloadFileFrom(url: URL, completion: @escaping(URL) -> Void) {
        let session = URLSession.shared
        let task = session.downloadTask(with: url) { (url, response, error) in
            guard let url = url else {return}
            completion (url)
        }
        task.resume()
    }
    
}
