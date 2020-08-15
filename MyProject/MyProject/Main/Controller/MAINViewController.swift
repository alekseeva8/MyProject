//
//  MAINViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/30/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class MAINViewController: UIViewController {
    
    let decoder = JSONDecoder()
    var favorites: [Audio] = []
    var collectionView: UICollectionView
    let categories = [Category(name: "Songs", image: UIImage(named: "music-cake"), color: UIColor(named: "PinkCellColor")),
                     Category(name: "Stories", image: UIImage(named: "fantasy"), color: UIColor(named: "YellowCellColor")),
                     Category(name: "Videos", image: UIImage(named: "artist"), color: UIColor(named: "GreenCellColor")),
                     Category(name: "Favorities", image: UIImage(named: "hearts"), color: UIColor(named: "PurpleCellColor"))]
    
    required init?(coder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 15
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarStyle()
        
        view.addSubview(collectionView)
        collectionViewLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MAINCollectionViewCell.self, forCellWithReuseIdentifier: MAINCollectionViewCell.reuseID)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        favorites = []
    }
    
    func setNavigationBarStyle() {
        navigationController?.navigationBar.barTintColor = UIColor(named: "NavigationBarColor")
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
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
        
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "signed")
    }
    
    @IBAction func backToMainScreen(unwindSegue: UIStoryboardSegue) {
    }
}

//MARK: - Data Source
extension MAINViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MAINCollectionViewCell.reuseID, for: indexPath) as? MAINCollectionViewCell else  {fatalError("There is no cell")}
        cell.layer.cornerRadius = 10
        let category = categories[indexPath.row]
        cell.setCategory(category)
        return cell
    }
}

//MARK: - Delegate
extension MAINViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = UIScreen.main.bounds.width - 20 - 20 - 10/2
        return CGSize(width: itemWidth, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch  indexPath.row {
        case 0: performSegue(withIdentifier: "fromMainToSongsVC", sender: nil)
        case 1: performSegue(withIdentifier: "fromMainToStoriesVC", sender: nil)
        case 2: performSegue(withIdentifier: "fromMainToVideoVC", sender: nil)
        case 3:
            //get favorite songs from Firestore, set favorites array to pass later to FavoritesVC
            FirestoreHandler().getFavorites { (dictionariesArray) in
                dictionariesArray.forEach { (dictionary) in
                    do {
                        guard let jsonData = try? JSONSerialization.data(withJSONObject: dictionary) else {return}
                        let track = try self.decoder.decode(Track.self, from: jsonData)
                        guard let data = Data(base64Encoded: track.imageUrl) else {return}
                        let url = URL(string: track.trackUrl)
                        self.favorites.append(Audio(name: track.trackName, image: UIImage(data: data) ?? UIImage(), url: url, kind: track.kind, isFavorite: true))
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
                self.performSegue(withIdentifier: "fromMainToFavoritesVC", sender: nil)
            }
        default: break
        }
    }
    //pass favorites to FavoritesVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let favoritesVC = segue.destination as? FavoritesViewController {
            favoritesVC.favorites = self.favorites
        }
    }
}
