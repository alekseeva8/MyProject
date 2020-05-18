//
//  StoriesTableViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/22/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class StoriesCollectViewController: UIViewController {

    var collectionView: UICollectionView
    //let dataSourceStoriesCollection = DataSourceStoriesCollection()
    var stories = [Audio]()

    required init?(coder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = " Stories"
        
        view.addSubview(collectionView)
        collectionViewLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        //collectionView.dataSource = dataSourceStoriesCollection
        collectionView.register(StoriesCollectViewCell.self, forCellWithReuseIdentifier: StoriesCollectViewCell.reuseID)

        updateData()
    }
}

//MARK: - updateData
extension StoriesCollectViewController {
    func updateData() {
        ParseHandler().getData() {[weak self] (searchResponse) in
            searchResponse.results.forEach { (track) in
                if track.kind == "story" {
                guard let url = URL(string: track.trackUrl) else {return}
                guard let urlImage = URL(string: track.imageUrl) else {return}
                guard let data = try? Data(contentsOf: urlImage) else {return}
                self?.stories.append(Audio(name: track.trackName, image: UIImage(data: data) ?? UIImage(), url: url, kind: track.kind))
            }
            }
            self?.collectionView.reloadData()
        }
    }
}


//MARK: - DataSource
extension StoriesCollectViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCollectViewCell.reuseID, for: indexPath) as! StoriesCollectViewCell

        //cellDesign(cell: cell)
        cell.backgroundColor = UIColor(named: "BackgroundColor")
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 2

        cell.storyNameLabel.text = stories[indexPath.row].name
        cell.storyImageView.image = stories[indexPath.row].image

        return cell
    }

}

//MARK: - Layout, Design
extension StoriesCollectViewController {
    func collectionViewLayout() {
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

//MARK: - Delegate
extension StoriesCollectViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (UIScreen.main.bounds.width - 20 - 20 - 10/2)/2
        return CGSize(width: itemWidth, height: 250)
    }
}

//MARK: - DidSelect method
extension StoriesCollectViewController {
    //Tells the delegate that the item at the specified index path was selected.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //saving info in singleton to use it in AudioPlayerVC
        AudioManager.shared.currentAudio = indexPath.row
        //AudioManager.shared.audio = stories[indexPath.row]
        performSegue(withIdentifier: "fromStoriesToPlayerVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let audioPlayerVC = segue.destination as? AudioPlayerViewController {
            audioPlayerVC.audioArray = stories
        }
    }
}
