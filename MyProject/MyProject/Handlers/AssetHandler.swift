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
    static func getAssetURL(url: URL, completion: @escaping(URL) -> Void) {
        let fileManager = FileManager.default
        let docsDirectoryPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let docsDirectoryURL = docsDirectoryPath.first else {return}
        let newDirectoryURL = docsDirectoryURL.appendingPathComponent(url.lastPathComponent)

        //if audio has already been downloaded and saved to file system (to newDirectoryURL) return newDirectoryURL
        if fileManager.fileExists(atPath: newDirectoryURL.path) {
            completion(newDirectoryURL)
            print("from file system")
        }
        //if not - download audio from network and return tmpUrl. finally, save it to newDirectoryURL
        else {
            NetworkHandler.downloadAssetFrom(url: url) { (tmpUrl) in
                print("downloaded")
                completion(tmpUrl)
                do {
                    try fileManager.moveItem(at: tmpUrl, to: newDirectoryURL)
                    print("moved")
                } catch {
                    print(error)
                }
            }
        }
    }
}
