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

    var storiesArray = [Story]()

    override init() {
        super.init()
        storiesArray = CloudDataHandler.gettingStoriesArray()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        storiesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCollectViewCell.reuseID, for: indexPath) as! StoriesCollectViewCell

        //cellDesign(cell: cell)
        cell.backgroundColor = UIColor(named: "BackgroundColor")
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 2

        cell.storyNameLabel.text = storiesArray[indexPath.row].name

        return cell
    }


}
