//
//  AudioManager.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/28/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation
import UIKit

class AudioManager {
    //singleton
    static let shared = AudioManager()
    var currentAudio = 0

    var story = Story(name: "", image: UIImage(), url: URL(string: ""), kind: "")
    
    private init() {
    }
}
