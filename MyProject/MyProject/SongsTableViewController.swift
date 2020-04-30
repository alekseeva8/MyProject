//
//  SongsTableViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/22/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class SongsTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let dataSourceForSongsTable = DataSourceForSongsTable()
    var songsArray = DataSourceForSongsTable().songsArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Songs"
        tableView.delegate = self
        tableView.dataSource = dataSourceForSongsTable
    }
    //добавить  unwindSegue to MainVC
}


//MARK: - Delegate
extension SongsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //достаем название аудио из ячейки (сохраняем в синглтон и передаем в AudioPlayerVC)
        SongsManager.shared.songName = songsArray[indexPath.row].name
        SongsManager.shared.songNumber = indexPath.row
        performSegue(withIdentifier: "fromSongsTableToPlayerVC", sender: nil)
    }
}

