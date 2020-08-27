//
//  StoriesDataSource.swift
//  MyProject
//
//  Created by Elena Alekseeva on 8/27/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

struct StoriesDataSource {
    
    static func getStories(completion: @escaping ([Audio]) -> Void) {
        var stories: [Audio] = []
        DataHandler.getTracks() {(tracks) in
            tracks.results.forEach { (track) in
                if track.kind == "story" {
                    guard let url = URL(string: track.trackUrl) else {return}
                    guard let urlImage = URL(string: track.imageUrl) else {return}
                    guard let data = try? Data(contentsOf: urlImage) else {return}
                    guard let isFavorite = Bool("false") else {return}
                    stories.append(Audio(name: track.trackName, image: UIImage(data: data) ?? UIImage(), url: url, kind: track.kind, isFavorite: isFavorite))
                }
            }
            completion(stories)
        }
    }
}

