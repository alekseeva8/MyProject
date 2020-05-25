//
//  Audio.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/13/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import  UIKit

class Audio {
    var name: String
    var image: UIImage
    var url: URL?
    var kind: String
    var isFavorite: Bool

    init(name: String, image: UIImage, url: URL?, kind: String, isFavorite: Bool) {
        self.name = name
        self.image = image
        self.url = url
        self.kind = kind
        self.isFavorite = isFavorite
    }

}

