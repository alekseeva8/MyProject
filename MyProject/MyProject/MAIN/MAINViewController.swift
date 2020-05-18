//
//  MAINViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/30/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class MAINViewController: UIViewController {

    var collectionView: UICollectionView
    let categories = [Category(name: "Songs", image: UIImage(named: "music-cake") ?? UIImage()), Category(name: "Stories", image: UIImage(named: "fantasy") ?? UIImage()), Category(name: "Learning Videos", image: UIImage(named: "artist") ?? UIImage()), Category(name: "Favorities", image: UIImage(named: "hearts") ?? UIImage())]

    required init?(coder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 15
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = " Main"

        view.addSubview(collectionView)
        collectionViewLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MAINCollectionViewCell.self, forCellWithReuseIdentifier: MAINCollectionViewCell.reuseID)
    }
}

//MARK: - Data Source
extension MAINViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MAINCollectionViewCell.reuseID, for: indexPath) as! MAINCollectionViewCell

        cell.backgroundColor = UIColor(named: "PinkCellColor")
        cell.layer.cornerRadius = 10
        cell.activityNameLabel.text = categories[indexPath.row].name
        cell.activityImageView.image = categories[indexPath.row].image

        return cell
    }
}

//MARK: - Layout, Design
extension MAINViewController {
    func collectionViewLayout() {
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        collectionView.contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }

}

//MARK: - Delegate
extension MAINViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = UIScreen.main.bounds.width - 20 - 20 - 10/2
        //let itemWidth = 350
        return CGSize(width: itemWidth, height: 150)
    }
}

//MARK: - DidSelect method
extension MAINViewController {
    //Tells the delegate that the item at the specified index path was selected.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch  indexPath.row {
        case 0: performSegue(withIdentifier: "fromMainToSongsVC", sender: nil)
        case 1: performSegue(withIdentifier: "fromMainToStoriesVC", sender: nil)
        case 2: performSegue(withIdentifier: "fromMainToVideoVC", sender: nil)
        default:
            break
        }
    }


}
