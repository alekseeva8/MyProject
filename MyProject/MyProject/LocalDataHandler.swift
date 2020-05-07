//
//  LocalDataHandler.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/7/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation
import  UIKit

class LocalDataHandler {

    static func gettingSongsArray() -> [Song] {
        var arrayOfSongs: [Song] = []

        //getting url to all of the files (to directory)
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath ?? "")
        //getting access to all of the files. All files will be stored in urlsArray
        do {
            let urlsArray = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            //print(urlsArray)
            urlsArray.forEach { (url) in
                let urlString = url.absoluteString
                if urlString.contains(".mp3") {
                    //print(urlString)
                    let urlStringSplitted = urlString.split(separator: "/")
                    var songName = String(urlStringSplitted.last ?? "")
                    songName = songName.replacingOccurrences(of: ".mp3", with: "")
                    songName = songName.replacingOccurrences(of: "%20", with: " ")
                    guard let path = Bundle.main.path(forResource: songName, ofType: "mp3") else {return}
                    let url = URL(fileURLWithPath: path)
                    arrayOfSongs.append(Song(name: songName, image: UIImage(named: songName) ?? UIImage(), url: url))
                }
            }
        } catch {
            print(error)
        }
        return arrayOfSongs
    }
}

