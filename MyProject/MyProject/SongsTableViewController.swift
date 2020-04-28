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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Songs"
        tableView.delegate = self
        tableView.dataSource = dataSourceForSongsTable
    }
}


//MARK: - Delegate
extension SongsTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}


