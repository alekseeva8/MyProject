//
//  AssetHandler.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/20/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

class AssetHandler {

    //get url for AudioPlayer
    static func getURL(_ url: URL, completion: @escaping(URL) -> Void) {
        let fileManager = FileManager.default
        let docsDirectoryPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let docsDirectoryURL = docsDirectoryPath.first else {return}
        let newDirectoryURL = docsDirectoryURL.appendingPathComponent(url.lastPathComponent)
        
        switch fileManager.fileExists(atPath: newDirectoryURL.path) {
        case true:
            completion(newDirectoryURL)  //return newDirectoryURL
        default:
            NetworkHandler.downloadAssetFrom(url: url) { (tmpUrl) in
                completion(tmpUrl) //download audio from network and return tmpUrl
                do {
                    try fileManager.moveItem(at: tmpUrl, to: newDirectoryURL)  //save audio to newDirectoryURL
                } catch {
                    print(error)
                }
            }
        }
    }
}
