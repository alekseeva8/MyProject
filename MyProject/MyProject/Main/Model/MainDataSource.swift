//
//  MainDataSource.swift
//  MyProject
//
//  Created by Elena Alekseeva on 8/27/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

struct MainDataSource {
    
    //get favorite songs from Firestore, set favorites array to pass later to FavoritesScreen
    static func getFavorites(completion: @escaping ([Audio]) -> Void) {
        var favorites: [Audio] = []
        FirestoreHandler().getFavorites { (dictionariesArray) in
            dictionariesArray.forEach { (dictionary) in
                do {
                    guard let jsonData = try? JSONSerialization.data(withJSONObject: dictionary) else {return}
                    let decoder = JSONDecoder()
                    let track = try decoder.decode(Track.self, from: jsonData)
                    guard let data = Data(base64Encoded: track.imageUrl) else {return}
                    let url = URL(string: track.trackUrl)
                    favorites.append(Audio(name: track.trackName, image: UIImage(data: data) ?? UIImage(), url: url, kind: track.kind, isFavorite: true))
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            completion(favorites)
        }
    }
}
