//
//  NetworkHandler.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/7/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

class NetworkHandler {

    //download audio from network
    static func downloadAssetFrom(url: URL, completion: @escaping(URL) -> Void) {
        let session = URLSession.shared
        let task = session.downloadTask(with: url) { (tmpUrl, response, error) in
            guard let tmpUrl = tmpUrl else {return}
            completion(tmpUrl)
        }
        task.resume()
    }
}
