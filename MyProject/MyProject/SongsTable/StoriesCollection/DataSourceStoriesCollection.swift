//
//  DataSourceStoriesCollection.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/7/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation
import UIKit

class DataSourceStoriesCollection: NSObject, UICollectionViewDataSource {

    var songsArray = [Song]()

    override init() {
        super.init()
        //изменить на другой источник данных!!!!!
        songsArray = LocalDataHandler.gettingSongsArray()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        songsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCollectViewCell.reuseID, for: indexPath) as! StoriesCollectViewCell

        //cellDesign(cell: cell)
        cell.backgroundColor = UIColor(named: "BackgroundColor")
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 2

        cell.storyNameLabel.text = songsArray[indexPath.row].name
        cell.storyImageView.image = songsArray[indexPath.row].image

        return cell
    }


}
