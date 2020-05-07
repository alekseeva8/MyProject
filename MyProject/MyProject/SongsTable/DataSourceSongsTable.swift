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
    }
    
    //MARK: - DataSource functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var songsTableViewCell: UITableViewCell
        songsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "songsTableViewCell", for: indexPath)
        songsTableViewCell.textLabel?.text = songsArray[indexPath.row].name
        songsTableViewCell.imageView?.image = songsArray[indexPath.row].image
        return songsTableViewCell
    }
}

