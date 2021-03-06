//
//  StoriesViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/22/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController {
    
    private var collectionView: UICollectionView
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var stories = [Audio]()
    
    required init?(coder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 15
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = " Stories"
        
        view.addSubview(collectionView)
        
        configureCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StoriesCollectionViewCell.self, forCellWithReuseIdentifier: StoriesCollectionViewCell.reuseID)
        
        getStories()
        
        collectionView.addSubview(activityIndicator)
        configureActivityIndicator()
        activityIndicator.startAnimating()
    }
    
    private func getStories() {
        StoriesDataSource.getStories { [weak self] (stories) in
            guard let self = self else {return}
            self.stories = stories
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = UIColor.backgroundColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    private func configureActivityIndicator() {
        activityIndicator.color = .systemBlue
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        activityIndicator.hidesWhenStopped = true
    }
}

//MARK: - DataSource
extension StoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCollectionViewCell.reuseID, for: indexPath) as? StoriesCollectionViewCell else  {fatalError("There is no cell")}
        cell.storyImageView.image = stories[indexPath.row].image
        return cell
    }
}

//MARK: - Delegate
extension StoriesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (UIScreen.main.bounds.width - 20 - 20 - 20)/2
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let audioNumber = indexPath.row
        let router = Router(presentor: self)
        router.showPlayerScreen(with: stories, audioNumber: audioNumber)
    }
}
