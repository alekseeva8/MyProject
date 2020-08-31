//
//  SongsDataSource.swift
//  MyProject
//
//  Created by Elena Alekseeva on 8/28/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

struct SongsDataSource {
    
    static func getSongs(completion: @escaping ([Audio]) -> Void) {
        var songs: [Audio] = []
        AudioHandler.getAudio { (audio) in
            audio.forEach { (audio) in
                if audio.kind == Kind.song.rawValue {
                    songs.append(audio)
                }
            }
            completion(songs)
        }
    }
    
    static func getFavorites(of audio: [Audio], completion: @escaping () -> Void) {
        
        FirestoreHandler().getFavorites {(dictionariesArray) in
            dictionariesArray.forEach { (dictionary) in
                dictionary.forEach { (key, value) in
                    let valueString = String.init(describing: value)
                    audio.forEach { (audio) in
                        if audio.name == valueString {
                            audio.isFavorite = true
                        }
                    }
                }
            }
            completion()
        }
    }
}
