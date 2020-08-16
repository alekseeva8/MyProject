//
//  DataHandler.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/9/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

class DataHandler {
    
    static func getTracks(completionHanndler: @escaping (Tracks) -> Void) {
        APIHandler.requestDataToAPI(urlString: Constants.urlStringAPI) { (data) in
            do {
                let tracks = try JSONDecoder().decode(Tracks.self, from: data)
                DispatchQueue.main.async {
                    completionHanndler(tracks)
                }
            } catch let error {
                print(error)
            }
        }
    }
}
