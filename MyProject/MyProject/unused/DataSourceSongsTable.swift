//
//  DataSourceSongsTable.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/28/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation
import UIKit

class DataSourceSongsTable: NSObject, UITableViewDataSource {

    var songsArray = [Song]()
    
    override init() {
        super.init()
        songsArray = LocalDataHandler.gettingSongsArray()
        print(songsArray.count)
    }
    
    //MARK: - DataSource functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ParseHandler().getData() {[weak self] (searchResponse) in
            searchResponse.results.forEach { (track) in
                if track.kind == "song" {
                guard let url = URL(string: track.trackUrl) else {return}
                guard let urlImage = URL(string: track.image) else {return}
                guard let data = try? Data(contentsOf: urlImage) else {return}
                self?.songsArray.append(Song(name: track.trackName, image: UIImage(data: data) ?? UIImage(), url: url, kind: "song"))
            }
            }
            tableView.reloadData()
    }
        print(self.songsArray.count)
        return songsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var songsTableViewCell: UITableViewCell
        songsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "songsTableViewCell", for: indexPath)
        songsTableViewCell.textLabel?.text = songsArray[indexPath.row].name
        songsTableViewCell.imageView?.image = songsArray[indexPath.row].image
        return songsTableViewCell
    }
}

