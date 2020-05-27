//
//  AudioHandler.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/20/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

class AudioHandler {
    
    static func getAudioURL(url: URL, completion: @escaping(URL) -> Void) {
        let fileManager = FileManager.default
        let docsDirectoryPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let docsDirectoryURL = docsDirectoryPath.first else {return}
        let newDirectoryURL = docsDirectoryURL.appendingPathComponent(url.lastPathComponent)
        
        if fileManager.fileExists(atPath: newDirectoryURL.path) {
            completion(newDirectoryURL)
            print("from file system")
        }
        else {
            NetworkManager.downloadFileFrom(url: url) { (url) in
                print("downloaded")
                completion(url)
                do{
                    try fileManager.moveItem(at: url, to: newDirectoryURL)
                    print("moved")
                } catch {
                    print(error)
                }
            }
        }
    }
}
