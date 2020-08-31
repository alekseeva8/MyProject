//
//  StoriesDataSource.swift
//  MyProject
//
//  Created by Elena Alekseeva on 8/31/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

struct StoriesDataSource {
    
    static func getStories(completion: @escaping ([Audio]) -> Void) {
        var stories: [Audio] = []
        AudioHandler.getAudio { (audio) in
            audio.forEach { (audio) in
                if audio.kind == Kind.story.rawValue {
                    stories.append(audio)
                }
            }
            completion(stories)
        }
    }
}
