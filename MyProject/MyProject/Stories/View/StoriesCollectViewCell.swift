//
//  StoriesCollectViewCell.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/29/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class StoriesCollectViewCell: UICollectionViewCell {
    
    static let reuseID = "StoriesCollectViewCell"
    
    let storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(storyImageView)
        
        storyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        storyImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        storyImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        storyImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        storyImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1.0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
