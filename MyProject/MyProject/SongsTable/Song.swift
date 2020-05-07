//
//  Song.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/29/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation
import  UIKit

struct Song {
    var name: String
    var image: UIImage
    var url: URL
    
    init(name: String, image: UIImage, url: URL) {
        self.name = name
        self.image = image
        self.url = url
    }
}

