//
//  MainCollectionViewCell.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/30/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    static let reuseID = "MainCollectionViewCell"
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(categoryImageView)
        addSubview(categoryNameLabel)
        
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false

        categoryImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        categoryImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        categoryImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        categoryNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        categoryNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        categoryNameLabel.trailingAnchor.constraint(equalTo: categoryImageView.leadingAnchor, constant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCategory(_ category: Category) {
        categoryImageView.image = category.image
        categoryNameLabel.text = category.name
        backgroundColor = category.color
    }
}
