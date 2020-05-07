//
//  Story.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/7/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation
import  UIKit

struct Story {
    var name: String
    //var image: UIImage
    var url: URL

    init(name: String, url: URL) {
        self.name = name
        //self.image = image
        self.url = url
    }
}
