//
//  FirestoreHandler.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/26/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class FirestoreHandler {
    
    private let database = Firestore.firestore()
    private var dictionariesArray = [[String: Any]]()
    private let currentUser = Auth.auth().currentUser?.uid
    private let favoriteSongs = "favoriteSongs"
    
    func getFavorites(completion: @escaping([[String : Any]]) -> Void) {
        guard let currentUser = currentUser else {return}
        let reference = database.document("users/\(currentUser)").collection(favoriteSongs)
        reference.getDocuments {(querySnapshot, error) in
            if let error = error {
                print("Error is \(error)")
            } else {
                guard let querySnapshot = querySnapshot else {return}
                for document in querySnapshot.documents {
                    let dictionary = document.data()
                    self.dictionariesArray.append(dictionary)
                }
                completion(self.dictionariesArray)
            }
        }
    }

    func addToFavorites(_ audio: Audio) {
        guard let currentUser = currentUser else {return}
        let reference = database.document("users/\(currentUser)").collection(favoriteSongs)

        guard let trackUrl = audio.url else {return}
        let trackUrlString = trackUrl.absoluteString
        let trackImage = audio.image
        guard let trackImageData = trackImage.jpegData(compressionQuality: 1) else {return}
        let trackImageDataString = trackImageData.base64EncodedString()

        reference.document("\(audio.name)-id").setData([
            "kind": "song",
            "trackName": "\(audio.name)",
            "trackUrl": "\(trackUrlString)",
            "imageUrl": "\(trackImageDataString)",
            "isFavorite": "true"], merge: true)
    }

    func deleteFromFavorites(_ audio: Audio) {
        guard let currentUser = currentUser else {return}
        let reference = database.document("users/\(currentUser)").collection(favoriteSongs)
        reference.document("\(audio.name)-id").delete() {(err) in
            if let err = err {
                print("Error removing document: \(err)")
            }
        }
    }
}
