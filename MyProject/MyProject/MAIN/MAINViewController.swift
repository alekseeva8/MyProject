//
//  MAINViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/30/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MAINViewController: UIViewController {
    let database = Firestore.firestore()
    let decoder = JSONDecoder()
    var favorites: [Audio] = []
    
    var collectionView: UICollectionView
    let categories = [Category(name: "Songs", image: UIImage(named: "music-cake") ?? UIImage(), color: UIColor(named: "PinkCellColor") ?? UIColor()), Category(name: "Stories", image: UIImage(named: "fantasy") ?? UIImage(), color: UIColor(named: "YellowCellColor") ?? UIColor()), Category(name: "Learning Videos", image: UIImage(named: "artist") ?? UIImage(), color: UIColor(named: "GreenCellColor") ?? UIColor()), Category(name: "Favorities", image: UIImage(named: "hearts") ?? UIImage(), color: UIColor(named: "PurpleCellColor") ?? UIColor())]
    
    required init?(coder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 15
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favorites = []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = " Main"
        setNavigationBarStyle()
        
        view.addSubview(collectionView)
        collectionViewLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MAINCollectionViewCell.self, forCellWithReuseIdentifier: MAINCollectionViewCell.reuseID)
    }
    
    func setNavigationBarStyle() {
        navigationController?.navigationBar.barTintColor = UIColor(named: "NavigationBarColor")
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        AppUserDefaults.saveUnsignedValue()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MAINCollectionViewCell.reuseID, for: indexPath) as! MAINCollectionViewCell
        
        cell.layer.cornerRadius = 10
        let category = categories[indexPath.row]
        cell.setCategory(category)
        return cell
    }
}

//MARK: - CollectionView Layout
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
        case 3: getFavorites {
            self.performSegue(withIdentifier: "fromMainToFavoritesVC", sender: nil)
            }
        default: break
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let favoritesVC = segue.destination as? FavoritesViewController {
            favoritesVC.favorites = self.favorites
        }
    }
}

extension MAINViewController {
    
    func getFavorites(completion: @escaping() -> Void) {
        guard let currentUser = Auth.auth().currentUser?.uid else {return}
        let ref = database.document("users/\(currentUser)").collection("favoriteSongs")
        ref.getDocuments {(querySnapshot, error) in
            if let error = error {
                print("Error is \(error)")
            }
            else {
                guard let querySnapshot = querySnapshot else {return}
                for document in querySnapshot.documents {
                    do {
                        let jsonData = try? JSONSerialization.data(withJSONObject:document.data())
                        let track = try self.decoder.decode(Track.self, from: jsonData!)
                        guard let data = Data(base64Encoded:track.imageUrl) else {return}
                        let url = URL(string: track.trackUrl)
                        print(url)
                        self.favorites.append(Audio(name: track.trackName, image: UIImage(data: data) ?? UIImage(), url: url, kind: track.kind, isFavorite: true))
                    } catch let error  {
                        print(error.localizedDescription)
                    }
                }
                completion()
            }
        }
    }
}
