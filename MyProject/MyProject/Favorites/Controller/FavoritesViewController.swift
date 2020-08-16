//
//  FavoritesViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/20/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var favorites = [Audio]()
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        view.backgroundColor = UIColor(named: "BackgroundColor")
        tableView.rowHeight = 60
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func homeButtonTapped(_ sender: UIBarButtonItem) {
        let router = Router(presentor: self)
        router.returnToMainScreen()
    }
}

//MARK: - Delegate
extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let audioNumber = indexPath.row
        let router = Router(presentor: self)
        router.showPlayerScreen(with: favorites, audioNumber: audioNumber)
    }
}

//MARK: - DataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "favoritesTableViewCell", for: indexPath)
        cell.textLabel?.text = favorites[indexPath.row].name
        cell.imageView?.image = favorites[indexPath.row].image
        cell.textLabel?.font = UIFont.systemFont(ofSize: 19)
        return cell
    }
}
