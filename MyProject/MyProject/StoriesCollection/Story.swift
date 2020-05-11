//
//  Story.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/7/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import  UIKit

struct Story {
    var name: String
    var image: UIImage
    var url: URL?
    var kind: String

    init(name: String, image: UIImage, url: URL?, kind: String) {
        self.name = name
        self.image = image
        self.url = url
        self.kind = kind
    }
}
