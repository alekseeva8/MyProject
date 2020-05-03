//
//  DataSourceForSongsTable.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/28/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation
import UIKit

class DataSourceForSongsTable: NSObject, UITableViewDataSource {

    var songsArray: [Song] = []
    
    override init() {
        super.init()
        songsArray = gettingSongsArray()
    }
    
    //MARK: - DataSource functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var songsTableViewCell: UITableViewCell
        songsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "songsTableViewCell", for: indexPath)
        songsTableViewCell.textLabel?.text = songsArray[indexPath.row].name
        songsTableViewCell.imageView?.image = songsArray[indexPath.row].image
        return songsTableViewCell
    }
    
    //MARK: - Func gettingSongsArray
    func gettingSongsArray() -> [Song] {
        var arrayOfSongNames: [String] = []
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
                    arrayOfSongNames.append(songName)
                    arrayOfSongs.append(Song(name: songName, image: UIImage(named: songName) ?? UIImage()))
                }
            }
        } catch {
            print(error)
        }
        return arrayOfSongs
    }
}

