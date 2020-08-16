//
//  SongsViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/22/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SongsViewController: UIViewController {
    let database = Firestore.firestore()
    
    @IBOutlet weak var tableView: UITableView!
    var songs = [Audio]()
    var favorites = [Audio]()
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Songs"
        view.backgroundColor = UIColor(named: "BackgroundColor")
        tableView.rowHeight = 60
        
        tableView.delegate = self
        tableView.dataSource = self
        
        songs = LocalAssetsHandler.getAssets()
        getSongs()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        favorites = []
    }
    
    func getSongs() {
        DataHandler.getTracks() {[weak self] (tracks) in
            tracks.results.forEach { (track) in
                
                if track.kind == "song" {
                    guard let url = URL(string: track.trackUrl) else {return}
                    guard let urlImage = URL(string: track.imageUrl) else {return}
                    guard let data = try? Data(contentsOf: urlImage) else {return}
                    guard let isFavorite = Bool("false") else {return}
                    self?.songs.append(Audio(name: track.trackName, image: UIImage(data: data) ?? UIImage(), url: url, kind: track.kind, isFavorite: isFavorite))
                }
            }
            //get favorite audio names, update songs array setting isFavority property's value to true
            FirestoreHandler().getFavorites { [weak self] (dictionariesArray) in
                dictionariesArray.forEach { (dictionary) in
                    dictionary.forEach { (key, value) in
                        let valueString = String.init(describing: value)
                        self?.songs.forEach { (song) in
                            if song.name == valueString {
                                song.isFavorite = true
                            }
                        }
                    }
                }
                self?.tableView.reloadData()
            }
            self?.tableView.reloadData()
        }
    }
    
    @IBAction func favoritesButtonPressed(_ sender: UIButton) {
        songs.forEach { (song) in
            if song.isFavorite == true {
                favorites.append(song)
            }
        }
        let router = Router(presentor: self)
        router.showFavoritesScreen(with: favorites)
    }
}

//MARK: - Delegate
extension SongsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let audioNumber = indexPath.row
        let router = Router(presentor: self)
        router.showPlayerScreen(with: songs, audioNumber: audioNumber)
    }
}

//MARK: - DataSource
extension SongsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "songsTableViewCell", for: indexPath) as? SongsTableViewCell else  {fatalError("There is no cell")}
        cell.textLabel?.text = songs[indexPath.row].name
        cell.imageView?.image = songs[indexPath.row].image
        cell.textLabel?.font = UIFont.systemFont(ofSize: 19)
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped(sender:isFavorite:)), for: .touchDown)
        
        switch songs[indexPath.row].isFavorite {
        case true:
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        default:
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        return cell
    }
    
    @objc func likeButtonTapped(sender: UIButton, isFavorite: Bool) {
        guard let cell = sender.superview?.superview as? SongsTableViewCell else { return}
        guard let indexPath = self.tableView.indexPath(for: cell) else {return}
        let song = songs[indexPath.row]
        
        switch song.isFavorite {
        case false:
            //add to Firestore
            addToFavorites(song)
            song.isFavorite = true
            tableView.reloadData()
        default:
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            //delete from Firestore
            deleteFromFavorites(song)
            song.isFavorite = false
            tableView.reloadData()
        }
    }

    func addToFavorites(_ audio: Audio) {
        FirestoreHandler().addToFavorites(audio)
    }

    func deleteFromFavorites(_ audio: Audio) {
        FirestoreHandler().deleteFromFavorites(audio)
    }
}
