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
    let dataSourceStoriesCollection = DataSourceStoriesCollection()
    
    //инициализация VC из storyboard и инициализация CollectionView в нем
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
        collectionView.dataSource = dataSourceStoriesCollection
        collectionView.delegate = self
        collectionView.register(StoriesCollectViewCell.self, forCellWithReuseIdentifier: StoriesCollectViewCell.reuseID)
    }
}
//добавить  unwindSegue to MainVC


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
        
        //чтобы ячейки не доставали до краев collectionview на 10
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
    //метод говорит делегату, какой выбран пользователем ряд (нажатием на ряд пользователем). здесь можно модифицировать ряд
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AudioManager.shared.currentAudio = indexPath.row
        performSegue(withIdentifier: "fromStoriesToPlayerVC", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let audioPlayerVC = segue.destination as? AudioPlayerViewController {
            audioPlayerVC.audioType = "story"
            print("audioType is story")
        }
    }
}
