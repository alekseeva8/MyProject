//
//  FirestoreManager.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/26/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class FirestoreManager {
    let database = Firestore.firestore()
    var dictionariesArray = [[String : Any]]()
    
    func getFavorites(completion: @escaping([[String : Any]]) -> Void) {
        guard let currentUser = Auth.auth().currentUser?.uid else {return}
        let ref = database.document("users/\(currentUser)").collection("favoriteSongs")
        ref.getDocuments {(querySnapshot, error) in
            if let error = error {
                print("Error is \(error)")
            }
            else {
                guard let querySnapshot = querySnapshot else {return}
                for document in querySnapshot.documents {
                    let dictionary = document.data()
                    self.dictionariesArray.append(dictionary)
                }
                completion(self.dictionariesArray)
            }
        }
    }
}
