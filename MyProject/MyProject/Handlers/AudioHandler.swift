//
//  AudioHandler.swift
//  MyProject
//
//  Created by Elena Alekseeva on 8/31/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

struct AudioHandler {
   
    static func getAudio(completion: @escaping ([Audio]) -> Void) {
        var audio: [Audio] = []
        
        DataHandler.getTracks() {(tracks) in
            tracks.results.forEach { (track) in
                
                guard let url = URL(string: track.trackUrl) else {return}
                guard let urlImage = URL(string: track.imageUrl) else {return}
                guard let data = try? Data(contentsOf: urlImage) else {return}
                guard let isFavorite = Bool("false") else {return}
                let image = UIImage(data: data) ?? UIImage()
                audio.append(Audio(name: track.trackName, image: image, url: url, kind: track.kind, isFavorite: isFavorite))
            }
            completion(audio)
        }
    }
}
