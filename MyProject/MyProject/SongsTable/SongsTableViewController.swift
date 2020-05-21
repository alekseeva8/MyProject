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

    //let dataSourceSongsTable = DataSourceSongsTable()
    var songs = [Audio]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Songs"
        view.backgroundColor = UIColor(named: "BackgroundColor")
        tableView.rowHeight = 60

        tableView.delegate = self
        //tableView.dataSource = dataSourceSongsTable
        tableView.dataSource = self

        songs = LocalDataHandler.gettingSongsArray()
        getData()
    }

    @IBAction func favoritesButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toFavoritesVC", sender: nil)
    }
}

//MARK: - getData
extension SongsTableViewController {
    func getData() {
        ParseHandler().getData() {[weak self] (searchResponse) in
            searchResponse.results.forEach { (track) in
                if track.kind == "song" {
                    guard let url = URL(string: track.trackUrl) else {return}
                    guard let urlImage = URL(string: track.imageUrl) else {return}
                    guard let data = try? Data(contentsOf: urlImage) else {return}
                    self?.songs.append(Audio(name: track.trackName, image: UIImage(data: data) ?? UIImage(), url: url, kind: track.kind))
                }
            }
            self?.tableView.reloadData()
        }
    }
}

//MARK: - Delegate
extension SongsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //saving info in singleton to use it in AudioPlayerVC
        AudioManager.shared.currentAudio = indexPath.row
        //AudioManager.shared.audio = songs[indexPath.row]
        performSegue(withIdentifier: "fromSongsTableToPlayerVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let audioPlayerVC = segue.destination as? AudioPlayerViewController {
            audioPlayerVC.audioArray = songs
        }
    }
}

//MARK: - DataSource
extension SongsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var songsTableViewCell: UITableViewCell
        let songsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "songsTableViewCell", for: indexPath) as! SongsTableViewCell
        //songsTableViewCell.tag
        songsTableViewCell.textLabel?.text = songs[indexPath.row].name
        songsTableViewCell.imageView?.image = songs[indexPath.row].image
        songsTableViewCell.textLabel?.font = UIFont.systemFont(ofSize: 19)
        return songsTableViewCell
    }
}
//var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as TableViewCell
//  cell.tag = indexPath.row
//  cell.like.tag = indexPath.row
//  cell.like.addTarget(self, action: "handleLikes:", forControlEvents: .TouchUpInside)
//  return cell
