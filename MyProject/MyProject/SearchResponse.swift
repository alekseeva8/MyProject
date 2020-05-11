//
//  SearchResponse.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/9/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

struct SearchResponse: Codable {
    let results: [Track]
}
struct Track: Codable {
    let kind: String
    let trackName: String
    let trackUrl: String
    let image: String
}