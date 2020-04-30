//
//  MAIN2ViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/30/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class MAIN2ViewController: UIViewController {

    var collectionView: UICollectionView

    //вынести в отдельный файл? dataSource?
    let activitiesArray = ["Songs", "Stories", "Learning videos", "Bedtime", "Favorities"]
    //let colors - подобрать массив цветов
    //let images - подобрать массив картинок

    //инициализация VC из storyboard и инициализация CollectionView в нем
    required init?(coder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
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
        collectionView.register(MAIN2CollectionViewCell.self, forCellWithReuseIdentifier: MAIN2CollectionViewCell.reuseID)
    }
}

//MARK: - Data Source
extension MAIN2ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        activitiesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MAIN2CollectionViewCell.reuseID, for: indexPath) as! MAIN2CollectionViewCell

        cell.backgroundColor = UIColor(named: "BackgroundColor")
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5

        cell.storyNameLabel.text = activitiesArray[indexPath.row]
        //cell.storyImageView.image = songsArray[indexPath.row].image

        return cell
    }
}

//MARK: - Layout, Design
extension MAIN2ViewController {
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
extension MAIN2ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = UIScreen.main.bounds.width - 20 - 20 - 10/2
        //let itemWidth = 350
        return CGSize(width: itemWidth, height: 150)
    }
}

//MARK: - DidSelect method
extension MAIN2ViewController {
    //метод говорит делегату, какой выбран пользователем ряд (нажатием на ряд пользователем). здесь можно модифицировать ряд
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
