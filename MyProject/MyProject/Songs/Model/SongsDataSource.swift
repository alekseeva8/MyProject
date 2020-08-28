//
//  SongsDataSource.swift
//  MyProject
//
//  Created by Elena Alekseeva on 8/28/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

struct SongsDataSource {
        
    static func getTracks(completion: @escaping ([Audio]) -> Void) {
        var songs: [Audio] = []
        
        DataHandler.getTracks() {(tracks) in
            tracks.results.forEach { (track) in
                
                if track.kind == "song" {
                    guard let url = URL(string: track.trackUrl) else {return}
                    guard let urlImage = URL(string: track.imageUrl) else {return}
                    guard let data = try? Data(contentsOf: urlImage) else {return}
                    guard let isFavorite = Bool("false") else {return}
                    songs.append(Audio(name: track.trackName, image: UIImage(data: data) ?? UIImage(), url: url, kind: track.kind, isFavorite: isFavorite))
                }
            }
            completion(songs)
        }
    }
    
    static func getFavorites(of songs: [Audio], completion: @escaping () -> Void) {
        
        FirestoreHandler().getFavorites {(dictionariesArray) in
            dictionariesArray.forEach { (dictionary) in
                dictionary.forEach { (key, value) in
                    let valueString = String.init(describing: value)
                    songs.forEach { (song) in
                        if song.name == valueString {
                            song.isFavorite = true
                        }
                    }
                }
            }
            completion()
        }
    }
}
