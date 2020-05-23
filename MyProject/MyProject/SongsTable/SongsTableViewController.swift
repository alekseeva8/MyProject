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
    var likes: [String] = []
    var favorites = [Audio]()

    
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let audioPlayerVC = segue.destination as? AudioPlayerViewController {
            audioPlayerVC.audioArray = songs
        }
        if let favoritesVC = segue.destination as? FavoritesViewController {
            favoritesVC.favorites = favorites
        }
}
}

//MARK: - getData
extension SongsTableViewController {
    func getData() {
        DataHandler().getData() {[weak self] (tracks) in
            tracks.results.forEach { (track) in
                if track.kind == "song" {
                    guard let url = URL(string: track.trackUrl) else {return}
                    guard let urlImage = URL(string: track.imageUrl) else {return}
                    guard let data = try? Data(contentsOf: urlImage) else {return}
                    guard let isFavorite = Bool("false") else {return}
                    self?.songs.append(Audio(name: track.trackName, image: UIImage(data: data) ?? UIImage(), url: url, kind: track.kind, isFavorite: isFavorite))
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
}

//MARK: - DataSource
extension SongsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songsTableViewCell", for: indexPath) as! SongsTableViewCell
        cell.textLabel?.text = songs[indexPath.row].name
        cell.imageView?.image = songs[indexPath.row].image
        cell.textLabel?.font = UIFont.systemFont(ofSize: 19)
        //cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchDown)
        return cell
    }
    
    @objc func likeButtonTapped(sender: UIButton) {
    }
}
