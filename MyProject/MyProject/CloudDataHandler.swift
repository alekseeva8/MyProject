//
//  CloudDataHandler.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/7/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation
import UIKit

class CloudDataHandler {

    static func gettingStoriesArray() -> [Story] {
        var arrayOfStories: [Story] = []
        var urlStringsArray: [String] = []
        let urlString = "https://storage.googleapis.com/bucket-for-songs/Coco.mp3"
        urlStringsArray.append(urlString)

        urlStringsArray.forEach { (urlString) in
            if urlString.contains(".mp3") {
                print(urlString)
                let urlStringSplitted = urlString.split(separator: "/")
                var storyName = String(urlStringSplitted.last ?? "")
                storyName = storyName.replacingOccurrences(of: ".mp3", with: "")
                storyName = storyName.replacingOccurrences(of: "%20", with: " ")
                guard let url = URL(string: urlString) else {return}
                arrayOfStories.append(Story(name: storyName, url: url))
                }
            }
        return arrayOfStories
        }
}
