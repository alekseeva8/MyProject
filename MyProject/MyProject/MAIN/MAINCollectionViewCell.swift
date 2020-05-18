//
//  MAINCollectionViewCell.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/30/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class MAINCollectionViewCell: UICollectionViewCell {

    static let reuseID = "MAINCollectionViewCell"
    
    let activityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let activityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(activityImageView)
        addSubview(activityNameLabel)
        
        activityImageView.translatesAutoresizingMaskIntoConstraints = false
        activityNameLabel.translatesAutoresizingMaskIntoConstraints = false

        activityImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        activityImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        activityImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        activityNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        activityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        activityNameLabel.trailingAnchor.constraint(equalTo: activityImageView.leadingAnchor, constant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
