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
        imageView.backgroundColor = UIColor(named: "BackgroundColor")
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Masha i Medved")
        return imageView
    }()

    let storyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(storyImageView)
        addSubview(storyNameLabel)

        storyImageView.translatesAutoresizingMaskIntoConstraints = false
        storyNameLabel.translatesAutoresizingMaskIntoConstraints = false

        storyImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        storyImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        storyImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        storyImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/2).isActive = true
        storyNameLabel.topAnchor.constraint(equalTo: storyImageView.bottomAnchor, constant: 20).isActive = true
        storyNameLabel.leadingAnchor.constraint(equalTo: storyImageView.leadingAnchor, constant: 5).isActive = true
        storyNameLabel.trailingAnchor.constraint(equalTo: storyImageView.trailingAnchor, constant: -5).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


