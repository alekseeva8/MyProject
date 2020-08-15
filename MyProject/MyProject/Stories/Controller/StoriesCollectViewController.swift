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
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var stories = [Audio]()
    
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
        
        collectionViewLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StoriesCollectViewCell.self, forCellWithReuseIdentifier: StoriesCollectViewCell.reuseID)
        
        getStories()
        
        collectionView.addSubview(activityIndicator)
        activityIndicatorLayout()
        activityIndicator.startAnimating()
    }
    
    func getStories() {
        DataHandler.getTracks() {[weak self] (tracks) in
            tracks.results.forEach { (track) in
                if track.kind == "story" {
                    guard let url = URL(string: track.trackUrl) else {return}
                    guard let urlImage = URL(string: track.imageUrl) else {return}
                    guard let data = try? Data(contentsOf: urlImage) else {return}
                    guard let isFavorite = Bool("false") else {return}
                    self?.stories.append(Audio(name: track.trackName, image: UIImage(data: data) ?? UIImage(), url: url, kind: track.kind, isFavorite: isFavorite))
                }
            }
            self?.collectionView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
    
    func collectionViewLayout() {
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    func activityIndicatorLayout() {
        activityIndicator.color = .systemBlue
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        activityIndicator.hidesWhenStopped = true
    }
}

//MARK: - DataSource
extension StoriesCollectViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCollectViewCell.reuseID, for: indexPath) as? StoriesCollectViewCell else  {fatalError("There is no cell")}
        cell.storyImageView.image = stories[indexPath.row].image
        return cell
    }
}

//MARK: - Delegate
extension StoriesCollectViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (UIScreen.main.bounds.width - 20 - 20 - 20)/2
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //saving info in singleton to use it in AudioPlayerVC
        AudioManager.shared.currentAudio = indexPath.row
        performSegue(withIdentifier: "fromStoriesToPlayerVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let audioPlayerVC = segue.destination as? AudioPlayerViewController {
            audioPlayerVC.audioArray = stories
        }
    }
}
