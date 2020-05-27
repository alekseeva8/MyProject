//
//  SongsTableViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/22/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SongsTableViewController: UIViewController {
    let database = Firestore.firestore()
    
    @IBOutlet weak var tableView: UITableView!
    var songs = [Audio]()
    var favorites = [Audio]()
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favorites = []
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
    
    @IBAction func favoritesButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toFavoritesVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let audioPlayerVC = segue.destination as? AudioPlayerViewController {
            audioPlayerVC.audioArray = songs
        }
        if let favoritesVC = segue.destination as? FavoritesViewController {
            songs.forEach { (song) in
                if song.isFavorite == true {
                    favorites.append(song)
                }
            }
            favoritesVC.favorites = self.favorites
        }
    }
}

//MARK: - getSongs
extension SongsTableViewController {
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
                print("2nd reloading after favorites received")
                self?.tableView.reloadData()
            }
            self?.tableView.reloadData()
            print("1st tableView reloading")
        }
    }
}

//MARK: - Delegate
extension SongsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //saving info in singleton to use it in AudioPlayerVC
        AudioManager.shared.currentAudio = indexPath.row
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
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped(sender:isFavorite:)), for: .touchDown)
        if  songs[indexPath.row].isFavorite == true {
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else  if songs[indexPath.row].isFavorite == false {
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        return cell
    }
    
    @objc func likeButtonTapped(sender: UIButton, isFavorite: Bool) {
        guard let cell = sender.superview?.superview as? SongsTableViewCell else { return}
        guard let indexPath = self.tableView.indexPath(for: cell) else {return}
        let song = songs[indexPath.row]
        
        if song.isFavorite == false {
            //add to Firestore
            addToFavorites(song)
            song.isFavorite = true
            tableView.reloadData()
        }
        else if song.isFavorite == true {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            //delete from Firestore
            deleteFromFavorites(song)
            song.isFavorite = false
            tableView.reloadData()
        }
    }
    
    //MARK: - Firestore functions
    func addToFavorites(_ audio: Audio) {
        FirestoreHandler().addToFavorites(audio)
    }

    func deleteFromFavorites(_ audio: Audio) {
        FirestoreHandler().deleteFromFavorites(audio)
    }
}
